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
    end

    it 'should invalid if x negative' do
      table = Table.new
      expect(table.valid_position?([-1, 0])).to eq false
    end

    it 'should invalid if y negative' do
      table = Table.new
      expect(table.valid_position?([0, -1])).to eq false
    end
  end
end
