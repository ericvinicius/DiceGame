class_name Power

var value: int
var type: AttackType
var _range: AttackRange
var area: AttackArea

func _init(value: int, type: AttackType, _range: AttackRange, area: AttackArea):
	self.value = value
	self.type = type
	self._range = _range
	self.area = area
	pass


