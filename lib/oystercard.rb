class OysterCard

attr_reader(:balance)
attr_reader(:MAX_AMOUNT)

  def initialize
    @balance = 0
    @MAX_AMOUNT = 90
  end

  def top_up(amount)
    if (@balance + amount) > @MAX_AMOUNT
      raise "Error: adding #{amount} will exceed the maximum value of #{@MAX_AMOUNT}"
    else
      @balance += amount
    end
  end

  def deduct(amount)
    @balance -= amount
  end
end
