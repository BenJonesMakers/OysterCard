class Journey

  attr_reader :entry_station

  def initialize
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def start(station)
    @in_journey = true
    @entry_station = station
  end

  def end(station)
    @in_journey = false
    journey_log(@entry_station, station)
    @exit_station = station
  end

  def fare
    if valid?(@entry_station) && valid?(@exit_station)
      return OysterCard::MIN_JOURNEY_COST
    else
      OysterCard::PENALTY_FARE
    end
  end

  def in_journey?
    @in_journey
  end

  def show_journeys
    @journeys
  end

  private

  def journey_log(entry_station, exit_station)
    @journeys << {:entry => entry_station, :exit => exit_station}
  end

  def valid?(station)
    !!station
  end
end
