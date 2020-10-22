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
    let (:entry_station) {:station}

    it { is_expected.to respond_to(:touch_in).with(1).argument}

    context "positive balance of more that 1" do
      it "can touch in" do
        allow(subject).to receive(:balance).and_return(10)
        expect(subject.touch_in(entry_station)).to eq entry_station
      end

      it "check to see if we are touching in again and returning a penalty" do
        subject.top_up(20)
        subject.touch_in(entry_station)
        expect { subject.touch_in(entry_station) }.to change { subject.balance }.by (-OysterCard::PENALTY_FARE)
      end
    end

    context "zero balance" do
      it "raises an error due to lack of funds" do
        allow(subject).to receive(:balance).and_return(0)
        expect { subject.touch_in(entry_station) }.to raise_error(NoFunds, "insufficient funds")
      end
    end

  end

  describe "#touch_out" do
    let(:station) { :station }

    it {is_expected.to respond_to(:touch_out).with(1).argument}

    it "can touch out" do
      expect(subject.touch_out(station)).to eq station
    end

    it "touch out reduces balance by MIN_JOURNEY_COST" do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(- OysterCard::MIN_JOURNEY_COST)
    end

  end

end
