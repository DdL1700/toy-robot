require 'command_reader'
require 'robot'

RSpec.describe CommandReader do
  it 'should have constants AVAILABLE_COMMANDS' do
    expect(CommandReader::AVAILABLE_COMMANDS).to eq %w[PLACE MOVE LEFT RIGHT REPORT]
  end

  context '#execute' do
    it 'should not execute an invalid command' do
      robot = Robot.new
      CommandReader.execute('test', robot)
      CommandReader.execute(nil, robot)
      CommandReader.execute('place', robot)
      CommandReader.execute('move', robot)
      CommandReader.execute('   ', robot)

      expect(robot.x).to eq nil
      expect(robot.y).to eq nil
      expect(robot.direction).to eq nil
    end

    it 'should read command and execute' do
      robot = Robot.new
      CommandReader.execute('PLACE 0,0,NORTH', robot)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :north
      CommandReader.execute('MOVE', robot)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :north
      CommandReader.execute('LEFT', robot)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :west
      CommandReader.execute('LEFT', robot)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :south
      CommandReader.execute('PLACE 3,3,SOUTH', robot)
      expect(robot.x).to eq 3
      expect(robot.y).to eq 3
      expect(robot.direction).to eq :south
      CommandReader.execute('PLACE 5,5,WEST', robot)
      expect(robot.x).to eq 3
      expect(robot.y).to eq 3
      expect(robot.direction).to eq :south
      CommandReader.execute('RIGHT', robot)
      expect(robot.x).to eq 3
      expect(robot.y).to eq 3
      expect(robot.direction).to eq :west
      expect { CommandReader.execute('REPORT', robot) }.to output("\"3,3,WEST\"\n").to_stdout
    end

    it 'should ignore args after MOVE LEFT REPORT REPORT' do
      robot = Robot.new
      robot.place(0, 0, :north)
      CommandReader.execute('MOVE 1,2,3,A,B', robot)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :north
      CommandReader.execute('LEFT 1,2,3,A,B', robot)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :west
      CommandReader.execute('RIGHT 1,2,3,A,B', robot)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :north
      expect { CommandReader.execute('REPORT', robot) }.to output("\"0,1,NORTH\"\n").to_stdout
    end

    it 'should not execute PLACE command if no args' do
      robot = Robot.new
      CommandReader.execute('PLACE', robot)
      expect(robot.x).to eq nil
      expect(robot.y).to eq nil
      expect(robot.direction).to eq nil
    end

    it 'should not execute PLACE command if position or direction is invalid' do
      robot = Robot.new
      CommandReader.execute('PLACE a,b,NORTH', robot)
      CommandReader.execute('PLACE 1,b,NORTH', robot)
      CommandReader.execute('PLACE 1,NORTH', robot)
      CommandReader.execute('PLACE 1,1', robot)
      CommandReader.execute('PLACE1,1 NORTH', robot)
      expect(robot.x).to eq nil
      expect(robot.y).to eq nil
      expect(robot.direction).to eq nil
    end
  end
end
