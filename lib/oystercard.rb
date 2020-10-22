class OysterCard

MIN_JOURNEY_COST = 1
PENALTY_FARE = 6

attr_reader(:balance)
attr_reader(:MAX_AMOUNT)

  def initialize
    @balance = 0
    @MAX_AMOUNT = 90
    @journey = Journey.new
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

    if @journey.in_journey?
      deduct(@journey.fare)
    else
      @journey.start(entry_station)
    end
  end

  def touch_out(exit_station)
    @journey.end(exit_station)
    deduct(@journey.fare)
    exit_station
  end

private

  def min_balance?
    self.balance < OysterCard::MIN_JOURNEY_COST
  end

  def deduct(amount)
    @balance -= amount
  end

end

class NoFunds < StandardError

end
