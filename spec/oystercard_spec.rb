require "oystercard"

describe OysterCard do
  it "expects balance to be available" do
    expect(subject).to respond_to(:balance)
  end

  it "expects balance to be 0" do
    expect(subject.balance).to eq 0
  end
end
