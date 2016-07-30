require 'spec_helper'

describe Robot do

  before :each do
    @terminator = Robot.new
    @wall_e = Robot.new
    @commander_data = Robot.new
    @skynet = Robot.new
  end
  
  describe "#scan_positions" do

    it "can keep track of all other Robots" do
      @terminator.instance_variable_set("@position", [2,2])
      @wall_e.instance_variable_set("@position", [2,2])
      @commander_data.instance_variable_set("@position", [1,2])

      @terminator.scan_positions([2,2])
      expect(@terminator.robot_positions.size).to eq(2)

      @terminator.scan_positions([1,2])
      expect(@terminator.robot_positions[2]).to eq(@commander_data)
    end
  end

end