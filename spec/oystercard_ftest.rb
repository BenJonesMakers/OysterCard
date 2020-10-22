require_relative '../lib/oystercard'
require_relative '../lib/station'

usercard01 = OysterCard.new

puts "initial balance - #{usercard01.balance}"

usercard01.top_up(10)
puts "top up with 10 - #{usercard01.balance}"

# superceeded test
#usercard01.touch(5)
#puts "deducts 5 from current balance leaving #{usercard01.balance}"

begin
  usercard01.touch_in("entry_station")
  puts "Passed touch_in"
rescue => error
  puts error.message
end

begin
  usercard01.in_journey?
  puts "Passed in_journey?"
rescue => error
  puts error.message
end

begin
  usercard01.touch_out("exit_station")
  puts "Passed touch_out"
rescue => error
  puts error.message
end

begin
  usercard02 = OysterCard.new
  usercard02.touch_in("entry_station")
  puts "touch in passed - balance is #{usercard02.balance}"
rescue NoFunds => error
  puts "expects error message 'insufficent funds'"
  puts error.message
rescue => error
  puts "Unexpected error"
  puts error.message
end

usercard03 = OysterCard.new
usercard03.top_up(10)
puts "\nminimum journey to be deducted"
puts "current balance - #{usercard03.balance}"
usercard03.touch_out("exit_station")
puts "new balance should be reduced by 1 - #{usercard03.balance}"

usercard04 = OysterCard.new
usercard04.top_up(10)
usercard04.touch_in("entry_station")
usercard04.show_touch_in_station

usercard05 = OysterCard.new
usercard05.top_up(10)
2.times do
  usercard05.touch_in("entry_station")
  usercard05.touch_out("exit_station")
end
usercard05.show_journeys

new_station = Station.new("Kings Cross", 3)
p new_station

p "test case for not touching in"
usercard06 = OysterCard.new
usercard06.top_up(10)
usercard06.touch_out(new_station)
p usercard06.show_journeys
