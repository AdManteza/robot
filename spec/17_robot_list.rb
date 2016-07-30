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
      expect(@terminator.robot_list.size).to eq(50)
      expect(@terminator.robot_list.include?(@wall_e)).to eq(true)
    end
  end

end