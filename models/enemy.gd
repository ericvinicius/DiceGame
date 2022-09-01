extends Character

class_name Enemy

var targets: Array

func _init(name: String, health: int, armour: int, dice: Dice):
	super(name, health, armour, dice)

func add_target(player: Player):
	self.targets.append(player)


func get_targets(players_count: int, power: Power, rng: RandomNumberGenerator = RandomNumberGenerator.new()):
	if power.area.group:
		var chunks = _chunks(range(0, players_count), power.area.how_many)
		return chunks[rng.randi_range(0, chunks.size()-1)]
	
	var targets: Array
	for idx in range(0, power.area.how_many):
		targets.append(rng.randi_range(0, players_count-1))
	return targets

func _chunks(list: Array, size: int):
	var chunks: Array
	for idx in range(0, list.size()):
		if idx+size > list.size():
			return chunks
		chunks.append(list.slice(idx, idx+size-1))
	return chunks
