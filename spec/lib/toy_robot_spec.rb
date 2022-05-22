require 'toy_robot'

RSpec.describe ToyRobot do
  it 'should read file and outputs results' do
    expect { ToyRobot.play(file: 'spec/fixtures/commands.text') }.to output(
      "\"0,1,NORTH\"\n\"0,0,WEST\"\n\"3,3,NORTH\"\n\"3,4,WEST\"\n\"3,4,WEST\"\n"
    ).to_stdout
  end
end
