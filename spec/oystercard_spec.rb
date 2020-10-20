require "oystercard"

RSpec::Matchers.define :be_boolean do
  match do |actual_value|
    [true, false].include? actual_value
  end
end

describe OysterCard do
  describe "#balance" do
    it "responds" do
      expect(subject).to respond_to(:balance)
    end

    it "expects starting balance to be 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "responds" do
      expect(subject).to respond_to(:top_up).with(1).arguments
    end

    it "returns new value" do
      expect(subject.top_up(10)).to eq 10
    end

    it "returns a changed balance" do
      expect { subject.top_up(20) }.to change { subject.balance }.by(20)
    end

    it "errors if balance will be greater than £90" do
      amount = 91
      expect {subject.top_up(91)}.to raise_error "Error: adding #{amount} will exceed the maximum value of #{subject.MAX_AMOUNT}"
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in)}

    context "positive balance of more that 1" do
      it "can touch in" do
        allow(subject).to receive(:balance).and_return(10)
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end

    context "zero balance" do
      it "raises an error due to lack of funds" do
        allow(subject).to receive(:balance).and_return(0)
        expect { subject.touch_in }.to raise_error(NoFunds, "insufficient funds")
      end
    end

  end

  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?)}
  end

  describe "#touch_out" do
    it {is_expected.to respond_to(:touch_out)}

    it "can touch out" do
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

    it "touch out reduces balance by MIN_JOURNEY_COST" do
      subject.top_up(10)
      expect { subject.touch_out }.to change { subject.balance }.by(- OysterCard::MIN_JOURNEY_COST)
    end
  end

end
