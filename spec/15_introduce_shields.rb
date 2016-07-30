require 'spec_helper'

describe Robot do
  
  before :each do
    @robot1 = Robot.new
    @robot2 = Robot.new 
    @plasma = PlasmaCannon.new
  end

  it "has 50 shield" do
    expect(@robot1.shield_points).to eq(50)
  end

  describe "#wound" do
    it "should first drain the shield_points" do
      @robot2.instance_variable_set("@shield_points", 0)
      @robot2.instance_variable_set("@health", 100)
      
      @robot1.attack(@robot2)

      expect(@robot2.shield_points).to eq(0)
      expect(@robot2.health).to eq(95)
    end
  end
end







