# frozen_string_literal: true

class CommandReader
  AVAILABLE_COMMANDS = %w[PLACE MOVE LEFT RIGHT REPORT].freeze

  def self.execute(raw_command, robot)
    command, args = raw_command.strip.split(' ')

    return unless AVAILABLE_COMMANDS.include?(command)

    case command
    when 'PLACE'
      unless args.nil?
        x, y, direction = args.split(',')
        number_reg = Regexp.new(/\A\d+\z/)
        if x =~ number_reg && y =~ number_reg
          robot.public_send(command.downcase.to_sym, x.to_i, y.to_i, direction.to_s.downcase.to_sym)
        end
      end
    else
      robot.public_send(command.downcase.to_sym)
    end
  end
end
