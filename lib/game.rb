require_relative 'robot'
require_relative 'command_reader'

class Game
  def self.play
    @robot = Robot.new
    File.foreach('commands.txt') do |raw_command|
      CommandReader.execute(raw_command, @robot)
    end
  end
end

Game.play
