require "oystercard"

describe OysterCard do
  it "#balance" do
    expect(subject).to respond_to(:balance)
  end

  it "expects balance to be 0" do
    expect(subject.balance).to eq 0
  end

  it "#top_up" do
    expect(subject).to respond_to(:top_up).with(1).arguments
  end

  it "returns new value" do
    expect(subject.top_up(10)).to eq 10
  end

  it "returns a changed balance" do
    expect { subject.top_up(20) }.to change { subject.balance }.by(20)
  end
end
