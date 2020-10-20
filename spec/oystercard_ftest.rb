require_relative '../lib/oystercard'

usercard01 = OysterCard.new

puts "initial balance - #{usercard01.balance}"

usercard01.top_up(10)
puts "top up with 10 - #{usercard01.balance}"

usercard01.deduct(5)
puts "deducts 5 from current balance leaving #{usercard01.balance}"

begin
  usercard01.touch_in
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
  usercard01.touch_out
  puts "Passed touch_out"
rescue => error
  puts error.message
end
