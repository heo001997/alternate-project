# frozen_string_literal: true

class AccommodationOptimizer
  def initialize(guest_count)
    @guest_count = guest_count
    @optimal_option = []
    @total_price = 0
    @accommodations = [
      { room_type: 'Family', sleeps: 4, room_count: 1, price: 85 },
      { room_type: 'Double', sleeps: 2, room_count: 3, price: 50 },
      { room_type: 'Single', sleeps: 1, room_count: 2, price: 30 }
    ]
  end

  def execute
    return 'No option' if @guest_count <= 0 || not_enough_sleeps?

    build_optimal_option(@guest_count)

    "#{@optimal_option.join(' ')} - $#{@total_price}"
  end

  private

  def not_enough_sleeps?
    total_sleeps = @accommodations.sum { |accommodation| accommodation[:sleeps] * accommodation[:room_count] }
    @guest_count > total_sleeps
  end

  def build_optimal_option(guest_count)
    match_accommodation = @accommodations.find do |accommodation|
      next if accommodation[:room_count].zero?
      next if accommodation[:sleeps] > guest_count

      accommodation
    end

    guest_count_left = guest_count - match_accommodation[:sleeps]
    match_accommodation[:room_count] -= 1

    @optimal_option << match_accommodation[:room_type]
    @total_price += match_accommodation[:price]

    build_optimal_option(guest_count_left) if guest_count_left.positive?
  end
end
