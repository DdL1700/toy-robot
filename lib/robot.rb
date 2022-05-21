# frozen_string_literal: true

require_relative 'table'

class Robot
  AVAILABLE_DIRECTIONS = %i[north east south west].freeze

  attr_reader :x, :y, :direction

  def initialize
    @table = Table.new
  end

  def place(x, y, direction)
    return unless valid_place?(x, y, direction)

    @x = x
    @y = y
    @direction = direction
  end

  def move
    return unless placed?

    new_position = position.zip(move_abilities[@direction]).map do |value, move_ability|
      value + move_ability
    end
    @x, @y = new_position if @table.valid_position?(new_position)
  end

  def left
    return unless placed?

    @direction = directions[(directions.find_index(@direction) - 1) % directions.size]
  end

  def right
    return unless placed?

    @direction = directions[(directions.find_index(@direction) + 1) % directions.size]
  end

  def report
    return unless placed?

    p "#{@x},#{@y},#{@direction.to_s.upcase}"
  end

  private

  def position
    [@x, @y]
  end

  def placed?
    !!(@x && @y && @direction)
  end

  def directions
    AVAILABLE_DIRECTIONS
  end

  def move_abilities
    { north: [0, 1], east: [1, 0], south: [0, -1], west: [-1, 0] }
  end

  def valid_place?(x, y, direction)
    directions.include?(direction) && @table.valid_position?([x, y])
  end
end
