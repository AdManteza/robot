require_relative 'robot'
require 'pry'

robot1 = Robot.new
robot2 = Robot.new 
robot3 = Robot.new 
plasma = PlasmaCannon.new

# p robot1.inspect
# p robot2.inspect
# # robot1.pick_up(plasma)

# robot1.attack(robot2)#55
# robot1.attack(robot2)
# robot1.attack(robot2)
# binding.pry
# target_position = [0,0]
# robot1.scan_positions(target_position)

robot1.scan_positions([0,0])

p robot1.robot_list