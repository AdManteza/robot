require 'spec_helper'

describe Batteries do

  before :each do
    @battery = Batteries.new
    @robot = Robot.new
  end

  it "is an Item" do
    expect(@battery).to be_an(Item)
  end

  describe "#recharge_shield" do

    it "can recharge the robot's shield points" do
      @robot.instance_variable_set("@shield_points", 0)
      @battery.recharge_shield(@robot)
      expect(@robot.shield_points).to eq(50)
    end
  end


end