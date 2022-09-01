extends Node3D

@onready var camera = $Camera

var distance: float = 2.0
var height: float = 5
var back: float = 2
var up: Vector3 = Vector3(0,1,0)
var dices_obj: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setup():
	var dice_scn = preload("res://objects/CustomDice.tscn")
	var game_scn = get_parent()
	for p in game_scn.game.players:
		var dice: Dice = p.dice
		var dice_scn_obj = dice_scn.instantiate().setup(dice)
		dice_scn_obj.get_transform().origin = Vector3(0, 3, 0)
		self.add_child(dice_scn_obj)
		dice_scn_obj.roll(5)
		self.dices_obj.append(dice_scn_obj)
		

func _physics_process(delta):
	var tx = 0
	var ty = 0
	var tz = 0
	var c_dices = self.dices_obj.size()
	for dice in self.dices_obj:
		var p = dice.get_global_transform().origin
		tx += p.x
		ty += p.y
		tz += p.z
	
	var target: Vector3 = Vector3(tx/c_dices, ty/c_dices, tz/c_dices)
	var pos: Vector3 = self.camera.get_global_transform().origin
	var offset: Vector3 = (pos - target).normalized()*distance
	offset.y = height
	offset.z = back
	pos = target + offset
	
	self.camera.look_at_from_position(pos, target, up)
	
func roll_dices():
	for dice in self.dices_obj:
		dice.roll(10)


