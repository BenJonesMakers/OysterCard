require "journey"

describe Journey do
  let(:station) { double :station }
  # we need start, end, pentaly_fare, in_progress?
  describe "#start" do


    it { is_expected.to respond_to(:start).with(1).argument }

    it "stores the starting station" do
      expect(subject.start(station)).to eq station
    end

    it "expects that in_journey? is true" do
      subject.start(station)
      expect(subject).to be_in_journey
    end

  end

  describe "#end" do
    it { is_expected.to respond_to(:end) }

    it "expects that in_progress is false" do
      subject.start(station)
      subject.end(station)
      expect(subject).to_not be_in_journey
    end
  end

  describe "#penalty_fare" do
    it { is_expected.to respond_to(:penalty_fare) }
  end

  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe "#show_journeys" do
    it {is_expected.to respond_to(:show_journeys)}

    it "displays an empty list of journeys on new card" do
      expect(subject.show_journeys).to eq []
    end

    it "displays all journeys entry/exit stations" do
      2.times do
        subject.start(station)
        subject.end(station)
      end
      expect(subject.show_journeys).to eq [
        { :entry => station, :exit => station},
        { :entry => station, :exit => station}
      ]
    end
  end
end
