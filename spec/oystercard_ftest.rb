require_relative '../lib/oystercard'

usercard01 = OysterCard.new

puts "initial balance - #{usercard01.balance}"

usercard01.top_up(10)
puts "top up with 10 - #{usercard01.balance}"

usercard01.deduct(5)
puts "deducts 5 from current balance leaving #{usercard01.balance}"
