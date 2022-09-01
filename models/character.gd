class_name Character

var name: String
var health: int
var armour: int
var dice: Dice
var current_power: Power
# var color: Color

func _init(name: String, health: int, armour: int, dice: Dice):
	self.name = name
	self.health = health
	self.armour = armour
	self.dice = dice
	
func id():
	self.name.to_lower()
	
func roll(value: int):
	print(value)
	print(self.dice.powers)
	self.current_power = self.dice.powers[value-1]
	return self.current_power
	
func damage(value: int):
	self.health -= value

func attack(to: Character):
	to.damage(self.current_power.value)
	return to.health <= 0
