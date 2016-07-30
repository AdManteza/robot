require 'spec_helper'

describe Robot do 

  describe "#scan_nearby" do 
    it "scans nearby robots(1 tile away)" do 
      @robot1 = Robot.new
      @robot2 = Robot.new
      @robot3 = Robot.new
      @robot4 = Robot.new

      @robot2.instance_variable_set("@position", [1,0])
      @robot3.instance_variable_set("@position", [0,1])
      @robot1.scan_nearby

      expect(@robot1.nearby_robots.include?(@robot4)).to eq(false)
    end
  end
end