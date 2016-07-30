class Robot
  MAX_WEIGHT = 250
  MAX_HEALTH = 100
  DEFAULT_ATTACK = 5
  CRITICAL_HEALTH = 80
  MOVE_SPEED = 1
  SHIELD_CRITICAL = 50

  @@robots = []

  attr_reader :position, :items, :items_weight, :health, :robot_positions, :nearby_robots
  attr_accessor :shield_points, :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
    @shield_points = 50
    @@robots.push(self)
    @robot_positions = []
    @nearby_robots = []
  end

  def move_left
    @position[0] -= MOVE_SPEED
  end

  def move_right
    @position[0] += MOVE_SPEED
  end

  def move_up
    @position[1] += MOVE_SPEED
  end

  def move_down
    @position[1] -= MOVE_SPEED
  end

  def pick_up(item)
    auto_replenish_shield if item.is_a?(Batteries)

    auto_heal(item) if item.is_a?(BoxOfBolts)

    @equipped_weapon = item if item.is_a?(Weapon)
    
    return false if capacity_full?(item)

    @items << item
    @items_weight += item.weight 
  end

  def wound(attack_damage)
    reduced_attack = raise_shield(attack_damage)

    if @health < reduced_attack
      @health -= @health
    else
      @health -= reduced_attack
    end
  end

  def heal(heal_points)
    if @health + heal_points > MAX_HEALTH
      @health = MAX_HEALTH
    else
      @health += heal_points
    end
  end

  def attack(enemy_robot)
    if @equipped_weapon
      if @equipped_weapon.is_a?(Grenade)
        @equipped_weapon.hit(enemy_robot) if grenade_range?(enemy_robot)
        self.equipped_weapon = nil
      elsif @equipped_weapon.is_a?(SpecialWeapon) 
        special_attack
      else
        @equipped_weapon.hit(enemy_robot)
      end
    elsif melee_positions?(enemy_robot)
      enemy_robot.wound(DEFAULT_ATTACK)
    end 
  end 

  def robot_list
    @@robots 
  end 

  def scan_positions(target_position)
    @@robots.each do |robot|
      @robot_positions.push(robot) if robot.position == target_position
    end 
  end

  def scan_nearby
    @@robots.each do |robot|
      @nearby_robots.push(robot) if nearby_y_position?(robot) || nearby_x_position?(robot)
    end
  end

  private

  def capacity_full?(item)
    capacity = MAX_WEIGHT - @items_weight

    if item.weight <= capacity
      return false
    else
      return true
    end
  end

  def raise_shield(attack_damage)
    if @shield_points >= attack_damage
      @shield_points -= attack_damage#shield_points reduced
      return 0
    elsif @shield_points <= attack_damage
      attack_damage -= @shield_points#shield reduces damage
      @shield_points -= @shield_points#shield is drained
      return attack_damage
    end
  end

  def melee_positions?(enemy_robot)
    return true if nearby_y_position?(enemy_robot)
    return true if @position == enemy_robot.position
  end

  def grenade_range?(enemy_robot)
    my_y_position = @position[1].abs
    enemy_y_position = enemy_robot.position[1].abs
    
    return true if (enemy_y_position - my_y_position) == MOVE_SPEED + 1
    return false if (enemy_y_position - my_y_position) > MOVE_SPEED + 2
  end

  def auto_heal(item)
    item.feed(self) if self.health <= CRITICAL_HEALTH
  end

  def auto_replenish_shield(item)
    item.charge_shield(self) if self.shield_points == SHIELD_CRITICAL
  end

  def nearby_y_position?(enemy_robot)
    my_y_position = @position[1].abs
    enemy_y_position = enemy_robot.position[1].abs

    return true if (enemy_y_position - my_y_position) == -MOVE_SPEED
    return true if (enemy_y_position - my_y_position) == MOVE_SPEED
    return false
  end

  def nearby_x_position?(enemy_robot)
    my_x_position = @position[0].abs
    enemy_x_position = enemy_robot.position[0].abs

    return true if (enemy_x_position - my_x_position) == -MOVE_SPEED
    return true if (enemy_x_position - my_x_position) == MOVE_SPEED
    return false
  end

  def special_attack
    scan_nearby

    @nearby_robots.each do |robot|
      robot.shield_points = 0
      @equipped_weapon.hit(robot)
    end

    self.shield_points = 0
    self.wound(@equipped_weapon.damage)
  end
end

class Item
  attr_reader :name, :weight

  def initialize(name, weight)
    @name = name
    @weight = weight
  end
end

class BoxOfBolts < Item
  HEAL_POINTS = 20

  def initialize
    super("Box of bolts", 25)
  end

  def feed(robot)
    robot.heal(HEAL_POINTS)
  end
end

class Batteries < Item
  def initialize
    super("Batteries", 25)
  end

  def recharge_shield(robot)
    robot.shield_points = 50 
  end
end

class Weapon < Item
  attr_reader :damage, :range

  def initialize(name, weight, damage=45, range=nil)
    super(name, weight)
    @damage = damage
    @range = range
  end

  def hit(robot)
    robot.wound(@damage)
  end
end

class Laser < Weapon
  def initialize
    super('Laser', 125, 25, 1)
  end
end

class PlasmaCannon < Weapon
  def initialize
    super('Plasma Cannon', 200, 55)
  end
end

class Grenade < Weapon
  def initialize
    super('Grenade', 40, 15, 2)
  end
end

class SpecialWeapon < Weapon
  def initialize
    super('NukeMe', 300, 30, 1)
  end
end




