class_name EnemyPanel

extends Container

var enemy: Enemy
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var dice_clicked: bool = false
var move_to: Vector2
var default_position: Vector2
var with_position: bool = false
var texture_ep: ImageTexture
var lines: Array

func setup(enemy: Enemy):
	add_to_group("enemies")
	self.enemy = enemy
	return self

func _ready():
	rng.randomize()
	$EnemyPanel/NamePanel/EnemyName.set_text(enemy.name)
	self.roll()
	
	var image = Image.new()
	image.load("res://images/hearth/full.png")
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	
	var image_ep = Image.new()
	image_ep.load("res://images/hearth/empty.png")
	self.texture_ep = ImageTexture.new()
	texture_ep.create_from_image(image_ep)
	
	$EnemyPanel/HealthPanel.add_constant_override("hseparation", 5)
	$EnemyPanel/HealthPanel.add_constant_override("vseparation", 5)
	
	for h in range(0, enemy.health):
		var sprite = TextureRect.new()
		sprite.set_texture(texture)
		$EnemyPanel/HealthPanel.add_child(sprite)

func roll():
	var value = rng.randi_range(1, 6)
	var power: Power = self.enemy.roll(value)
	self.set_dice_side(power.value, power.type.name, power.area.name)
	get_tree().call_group("game", "attack_player", power, self)

func add_line(to: Vector2):
	var from = Vector2(0, self.get_size().y/2)
	var diff_x = self.get_global_rect().position.x - to.x
	var diff_y = self.get_global_rect().position.y - to.y
	to = Vector2(abs(diff_x)*-1, self.get_position().y-diff_y-self.get_position().y)
	var line = Line2D.new()
	line.add_point(from)
	line.add_point(to)
	line.set_default_color(Color(1, 0, 0))
	line.set_z_index(-1)
	line.set_antialiased(true)
	line.set_width(1)
	self.add_child(line)
	self.lines.append(line)


func destroy():
	$EnemyPanel.set_visible(false)
	$EnemyClick.set_visible(false)
	for line in lines:
		self.remove_child(line)

func _on_Dice_pressed():
	print("Enemy Dice...")

func set_dice_side(value: int, type: String = "sword", area: String = "single", color: String = "red"):
	var atlas = AtlasTexture.new()
	atlas.set_atlas(load("res://images/dice/%s/%s/%s/map.png" % [color, type, area]))
	atlas.set_region(Rect2( 0, 64*value, 64, 64 ))
	$EnemyPanel/DicePanel/Dice.set_normal_texture(atlas)

func _on_EnemyClick_pressed():
	get_tree().call_group("game", "attack_enemy", self.get_position_in_parent(), self)


func update_health():
	var idx = 0
	for n in $EnemyPanel/HealthPanel.get_children():
		if idx >= self.enemy.health:
			var sprite = TextureRect.new()
			n.set_texture(self.texture_ep)
		idx += 1
		
