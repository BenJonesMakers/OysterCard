class Journey

  attr_reader :entry_station

  def initialize
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journeys = []
    @current_journey = Hash.new
  end

  def start(station)
    @in_journey = true
    @current_journey[:entry] = station
    @entry_station = station
  end

  def end(station)
    @in_journey = false
    @exit_station = station
    @current_journey[:exit] = station
    journey_log

    station
  end

  def fare
    if valid?(@entry_station) && valid?(@exit_station)
      @entry_station, @exit_station = nil, nil
      return OysterCard::MIN_JOURNEY_COST
    else
      @entry_station, @exit_station = nil, nil
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

  def current_journey
    @current_journey
  end

  def journey_log
    @journeys << @current_journey

  end

  def valid?(station)
    !!station
  end
end
