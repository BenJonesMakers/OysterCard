class OysterCard

MIN_JOURNEY_COST = 1

attr_reader(:balance)
attr_reader(:MAX_AMOUNT)

  def initialize
    @balance = 0
    @MAX_AMOUNT = 90
    @journeys = []
  end

  def top_up(amount)
    if (@balance + amount) > @MAX_AMOUNT
      raise "Error: adding #{amount} will exceed the maximum value of #{@MAX_AMOUNT}"
    else
      @balance += amount
    end
  end

  def touch_in(entry_station)
    raise NoFunds, "insufficient funds" if min_balance?

    @entry_station = entry_station
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_out(exit_station)
    deduct(MIN_JOURNEY_COST)
    journey_log(@entry_station, exit_station)
    @entry_station = nil
  end

  def show_touch_in_station
    @entry_station
  end

  def show_journeys
    @journeys
  end

private

  def min_balance?
    self.balance < OysterCard::MIN_JOURNEY_COST
  end

  def deduct(amount)
    @balance -= amount
  end

  def journey_log(entry_station, exit_station)
    @journeys << {:entry => entry_station, :exit => exit_station}
  end
end

class NoFunds < StandardError

end
