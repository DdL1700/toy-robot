require_relative 'toy_robot'
ToyRobot.play(file: ARGV[0] || 'commands.txt')
