class_name DiceScene

extends RigidBody

export var speed = 4.0

onready var up = $SideUp
onready var middle = $SideMiddle
onready var middle_down = $SideMiddleDown
onready var right = $SideRight
onready var left = $SideLeft
onready var down = $SideDown

var dice: Dice

func setup(dice: Dice):
	self.dice = dice
	add_to_group("dices")
	return self

func create_mat(color):
	var m = SpatialMaterial.new()
	m.albedo_color = color
	return m

func _ready():
	up.set_surface_material(0, create_mat(Color.red))
	down.set_surface_material(0, create_mat(Color.blue))
	middle.set_surface_material(0, create_mat(Color.brown))
	right.set_surface_material(0, create_mat(Color.purple))
	middle_down.set_surface_material(0, create_mat(Color.darkblue))
	left.set_surface_material(0, create_mat(Color.green))
	roll(2)

func create_image(color: Color) -> Image:
	var image = Image.new()
	image.create(1000, 1000, true, Image.FORMAT_RGB8)

	image.fill(color)

	return image

func roll(force: int):
	randomize()
	var x = rand_range(-5, 5)*force
	var y = rand_range(2, 5)*force
	var z = rand_range(-5, 5)*force
	self.set_angular_velocity(Vector3(x, y, z))
