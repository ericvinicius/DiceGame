class_name PlayerPanel

extends Container

signal dice_pressed

var player
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var dice_clicked: bool = false
var move_to: Vector2
var default_position: Vector2
var with_position: bool = false

@onready var hp_panel: GridContainer = $PlayerPanel/HealthPanel

func setup(player):
	add_to_group("players")
	self.player = player
	return self

func _ready():
	rng.randomize()
	$PlayerPanel/NamePanel/PlayerName.set_text(player.name)
	$PlayerPanel/DicePanel.set_visible(false)
	
	var image = Image.new()
	image.load("res://images/hearth/full.png")
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	
	
	for h in range(0, player.health):
		var sprite = TextureRect.new()
		sprite.set_texture(texture)
		hp_panel.add_child(sprite)


func _on_Dice_pressed():
	if self.dice_clicked:
		self.unselect()
	else:
		self.select()

func select():
	self.dice_clicked = true
	self.move_to = self.default_position + Vector2(30, 0)
	for chield in self.get_parent().get_children():
		if chield != self and chield.is_in_group("players"):
			chield.unselect()

func unselect():
	self.dice_clicked = false
	self.move_to = self.default_position

func disabled():
	$PlayerPanel/DicePanel/Dice.set_disabled(true)
	$PlayerPanel/DicePanel/Dice.set_self_modulate(Color(0.4, 0.4, 0.4))

func _process(delta):
	if not self.with_position:
		self.default_position = self.get_position()
		self.move_to = self.get_position()
		self.with_position = true

	var speed = 200
	if self.move_to != self.get_position():
		self.set_position(self.get_position().move_toward(self.move_to, delta*speed))
	
func _on_roll_pressed():
	self.unselect()
	$PlayerPanel/DicePanel.set_visible(true)
	
	if not $PlayerPanel/DicePanel/Dice.is_disabled():
		var value = rng.randi_range(1, 6)
		var power: Power = self.player.roll(value)
		self.set_dice_side(power.value, power.type.name, power.area.name)
	
func set_dice_side(value: int, type: String = "sword", area: String = "single", color: String = "red"):
	var atlas = AtlasTexture.new()
	atlas.set_atlas(load("res://images/dice/%s/%s/%s/map.png" % [color, type, area]))
	atlas.set_region(Rect2( 0, 64*value, 64, 64 ))
	$PlayerPanel/DicePanel/Dice.set_normal_texture(atlas)
	
	
