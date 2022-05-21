# frozen_string_literal: true

class Table
  attr_reader :row, :col

  def initialize(row: 4, col: 4)
    @row = row
    @col = col
  end

  def valid_position?(position)
    return false unless position.is_a?(Array) && position.none? { |element| !element.is_a?(Integer) }

    @x, @y = position
    valid_x? && valid_y?
  end

  private

  def valid_x?
    !!@x && @x >= 0 && @x <= @col
  end

  def valid_y?
    !!@y && @y >= 0 && @y <= @col
  end
end
