require 'spec_helper'

describe SpecialWeapon do 

  before :each do 
    @nuke = SpecialWeapon.new
  end

  it "is named as 'Special Weapon'" do 
    expect(@nuke.name).to eq('NukeMe')
  end

  it "is a Weapon" do
    expect(@nuke).to be_a(Weapon)
  end

  it "has a damage of 30" do
    expect(@nuke.damage).to eq(30)
  end
end

describe Robot do
  before :each do 
    @robot1 = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
    @nuke = SpecialWeapon.new
  end

  context "a robot equipped with special weapon" do
    it "can hit all nearby robots including himself" do
      @robot1.pick_up(@nuke)
      @robot2.move_right
      @robot3.move_down
      # @robot1.scan_nearby
      @robot1.attack(@robot2)

      expect(@robot1.equipped_weapon).to be_a(SpecialWeapon)
      expect(@robot1.nearby_robots.include?(@robot2)).to eq(true)
      expect(@robot1.nearby_robots.include?(@robot3)).to eq(true)
      expect(@robot1.health).to eq(70)
      expect(@robot2.health).to eq(70)
      expect(@robot3.health).to eq(70)
    end



  end

end

