# frozen_string_literal: true

require_relative 'accommodation_optimizer'

print 'Input: '
guest_count = gets.chomp.to_i

output = AccommodationOptimizer.new(guest_count).execute
puts "Output: #{output}"
