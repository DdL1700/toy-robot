require 'table'

RSpec.describe Table do
  it 'should have default row and col' do
    table = Table.new
    expect(table.row).to eq 4
    expect(table.col).to eq 4
  end

  context '#valid_position?' do
    it 'should be valid if inside table' do
      table = Table.new
      expect(table.valid_position?([0, 0])).to eq true
      expect(table.valid_position?([4, 4])).to eq true
      expect(table.valid_position?([2, 3])).to eq true
    end

    it 'should be invalid if x out of boundary' do
      table = Table.new
      expect(table.valid_position?([-1, 0])).to eq false
      expect(table.valid_position?([5, 0])).to eq false
    end

    it 'should be invalid if y out of boundary' do
      table = Table.new
      expect(table.valid_position?([0, -1])).to eq false
      expect(table.valid_position?([0, 5])).to eq false
    end

    it 'should be invalid if position is not integer array' do
      table = Table.new
      expect(table.valid_position?('a')).to eq false
      expect(table.valid_position?(nil)).to eq false
      expect(table.valid_position?(['a', 1])).to eq false
      expect(table.valid_position?(['a', nil])).to eq false
      expect(table.valid_position?([nil, 1])).to eq false
      expect(table.valid_position?(%w[1 1])).to eq false
    end

    it 'should be invalid if position array only 1 element' do
      table = Table.new
      expect(table.valid_position?([1])).to eq false
    end

    it 'should be valid if position array has more than 2 elements, program will take first two' do
      table = Table.new
      expect(table.valid_position?([1, 5, 5])).to eq false
      expect(table.valid_position?([1, 2, 5])).to eq true
    end
  end
end
