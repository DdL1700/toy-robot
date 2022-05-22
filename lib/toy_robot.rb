require_relative 'robot'
require_relative 'command_reader'

class ToyRobot
  def self.play(file:)
    @robot = Robot.new
    File.foreach(file) do |raw_command|
      CommandReader.execute(raw_command, @robot)
    end
  end
end
