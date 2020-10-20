class OysterCard

MIN_JOURNEY_COST = 1

attr_reader(:balance)
attr_reader(:MAX_AMOUNT)

  def initialize
    @balance = 0
    @MAX_AMOUNT = 90
    @in_journey = false
  end

  def top_up(amount)
    if (@balance + amount) > @MAX_AMOUNT
      raise "Error: adding #{amount} will exceed the maximum value of #{@MAX_AMOUNT}"
    else
      @balance += amount
    end
  end

  def touch_in
    raise NoFunds, "insufficient funds" if min_balance?

    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    deduct(MIN_JOURNEY_COST)
    @in_journey = false
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
