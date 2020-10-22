class Station

  attr_reader :name
  attr_reader :zone

  def initialize(name = "new station", zone = 0)
    @name = name
    @zone = zone
  end
end
