class_name AttackArea

var name: String
var how_many: int
var group: bool

func _init(name: String, how_many: int = 1, group: bool = true):
	self.name = name
	self.how_many = how_many
	self.group = group
	
