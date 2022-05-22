require 'robot'

RSpec.describe Robot do
  it 'should have constants AVAILABLE_DIRECTIONS' do
    expect(Robot::AVAILABLE_DIRECTIONS).to eq %i[north east south west]
  end

  it 'should have a table instance when instantiate a robot' do
    robot = Robot.new
    expect(robot.table.is_a?(Table)).to eq true
  end

  it 'should not set a position when instantiate a robot' do
    robot = Robot.new
    expect(robot.x).to eq nil
    expect(robot.y).to eq nil
    expect(robot.direction).to eq nil
  end

  context '#place' do
    it 'should place robot on table if position and direction are valid' do
      robot = Robot.new
      robot.place(0, 0, :north)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :north
      robot.place(1, 4, :west)
      expect(robot.x).to eq 1
      expect(robot.y).to eq 4
      expect(robot.direction).to eq :west
    end

    it 'should not place robot if place args are invalid' do
      robot = Robot.new
      robot.place(-1, 0, :north)
      robot.place(0, -1, :north)
      robot.place(5, 0, :north)
      robot.place(0, 5, :north)
      robot.place(0, 0, 'test')
      robot.place(nil, nil, nil)
      expect(robot.x).to eq nil
      expect(robot.y).to eq nil
      expect(robot.direction).to eq nil
    end

    it 'should not change current position for a invalid place' do
      robot = Robot.new
      robot.place(0, 0, :north)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :north
      robot.place(5, 5, :west)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :north
    end
  end

  context '#move' do
    it 'should not move if robot is not on table' do
      robot = Robot.new
      robot.move
      expect(robot.x).to eq nil
      expect(robot.y).to eq nil
      expect(robot.direction).to eq nil
    end

    it 'should move if was able to move after has been placed' do
      robot = Robot.new
      robot.place(0, 0, :north)
      expect(robot.x).to eq 0
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :north
      robot.move
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :north
      robot.move
      expect(robot.x).to eq 0
      expect(robot.y).to eq 2
      expect(robot.direction).to eq :north
    end

    it 'should not be able to move if position out of boundary' do
      robot = Robot.new
      robot.place(0, 0, :west)
      robot.move
      expect(robot.x).to eq 0
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :west
      robot.place(0, 0, :south)
      robot.move
      expect(robot.x).to eq 0
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :south
      robot.place(0, 4, :north)
      robot.move
      expect(robot.x).to eq 0
      expect(robot.y).to eq 4
      expect(robot.direction).to eq :north
      robot.place(4, 0, :east)
      robot.move
      expect(robot.x).to eq 4
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :east
    end

    it 'should move correctly for different directions' do
      robot = Robot.new
      robot.place(1, 1, :north)
      robot.move
      expect(robot.x).to eq 1
      expect(robot.y).to eq 2
      expect(robot.direction).to eq :north
      robot.place(1, 1, :west)
      robot.move
      expect(robot.x).to eq 0
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :west
      robot.place(1, 1, :south)
      robot.move
      expect(robot.x).to eq 1
      expect(robot.y).to eq 0
      expect(robot.direction).to eq :south
      robot.place(1, 1, :east)
      robot.move
      expect(robot.x).to eq 2
      expect(robot.y).to eq 1
      expect(robot.direction).to eq :east
    end
  end

  context '#left' do
    it 'should not turn left if not on table' do
      robot = Robot.new
      robot.left
      expect(robot.x).to eq nil
      expect(robot.y).to eq nil
      expect(robot.direction).to eq nil
    end

    it 'should turn left' do
      robot = Robot.new
      robot.place(0, 0, :north)
      robot.left
      expect(robot.direction).to eq :west
      robot.left
      expect(robot.direction).to eq :south
      robot.left
      expect(robot.direction).to eq :east
      robot.left
      expect(robot.direction).to eq :north
    end
  end

  context '#right' do
    it 'should not turn right if not on table' do
      robot = Robot.new
      robot.right
      expect(robot.x).to eq nil
      expect(robot.y).to eq nil
      expect(robot.direction).to eq nil
    end

    it 'should turn right' do
      robot = Robot.new
      robot.place(0, 0, :north)
      robot.right
      expect(robot.direction).to eq :east
      robot.right
      expect(robot.direction).to eq :south
      robot.right
      expect(robot.direction).to eq :west
      robot.right
      expect(robot.direction).to eq :north
    end
  end

  context '#report' do
    it 'should not report if robot not on table' do
      robot = Robot.new
      expect(robot.report).to eq nil
    end

    it 'should report robot current position' do
      robot = Robot.new
      robot.place(0, 0, :north)
      expect { robot.report }.to output("\"0,0,NORTH\"\n").to_stdout
      robot.move
      expect { robot.report }.to output("\"0,1,NORTH\"\n").to_stdout
      robot.right
      expect { robot.report }.to output("\"0,1,EAST\"\n").to_stdout
      robot.right
      expect { robot.report }.to output("\"0,1,SOUTH\"\n").to_stdout
      robot.left
      expect { robot.report }.to output("\"0,1,EAST\"\n").to_stdout
    end
  end

  context '#move_abilities' do
    it 'should return robot move_abilities' do
      robot = Robot.new
      move_abilities = robot.send(:move_abilities)
      expect(move_abilities[:north]).to eq [0, 1]
      expect(move_abilities[:east]).to eq [1, 0]
      expect(move_abilities[:south]).to eq [0, -1]
      expect(move_abilities[:west]).to eq [-1, 0]
    end
  end
end
