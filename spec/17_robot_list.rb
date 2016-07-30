require 'spec_helper'

describe Robot do
  
  before :each do
    @terminator = Robot.new
    @wall_e = Robot.new
    @commander_data = Robot.new
    @skynet = Robot.new
  end

  describe "#robot_list" do

    it "can keep track of all Robots" do
      expect(@terminator.robot_list.include?(@terminator)).to eq(true)
      expect(@terminator.robot_list.include?(@wall_e)).to eq(true)
      expect(@terminator.robot_list.include?(@commander_data)).to eq(true)
      expect(@terminator.robot_list.include?(@skynet)).to eq(true)
    end
  end

end