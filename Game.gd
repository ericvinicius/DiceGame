class_name Game

extends Node

signal roll_pressed

var game: GamePhase
var players_panels: Array
var rolled: bool = false
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	add_to_group("game")
	rng.randomize()
	
	var builder = GameBuilder.new()
	self.game = builder.create(1)
	self.create_players(game.players)
	self.create_enemies(game.enemies)
	$Game/Roll.set_text("Roll (x%s)" % game.rows_remaining)
	$DiceTable.setup()
	
func create_players(players: Array):
	var player_panel = preload("res://objects/PlayerPanel.tscn")
	for idx in len(players):
		var player: Player = players[idx]
		var panel: PlayerPanel = player_panel.instantiate().setup(player)
		self.connect("roll_pressed", panel._on_roll_pressed)
		$Game/PlayersBox.add_child(panel)
		self.players_panels.append(panel)
		
func create_enemies(enemies: Array):
	var enemy_panel = preload("res://objects/EnemyPanel.tscn")
	for idx in len(enemies):
		var enemy: Enemy = enemies[idx]
		var panel = enemy_panel.instantiate().setup(enemy)
		$Game/EnemyBox.add_child(panel)

func _on_MenuButton_pressed():
	print("Menu")
	get_tree().change_scene("res://Menu.tscn")


func _on_Roll_pressed():
	self.game.rows_remaining -= 1
	$DiceTable.roll_dices()
	$Game/Roll.set_text("Roll (x%s)" % game.rows_remaining)
	if self.game.rows_remaining == 0:
		$Game/Roll.set_disabled(true)
	emit_signal("roll_pressed")

func attack_player(power: Power, enemy_panel: EnemyPanel):
	var targets: Array = enemy_panel.enemy.get_targets(self.game.players.size(), power, self.rng)
	for target_nb in targets:
		var target_panel: PlayerPanel = $Game/PlayersBox.get_child(target_nb)
		var to = self._get_corner_point(target_panel, "left")
		enemy_panel.add_line(to)
		enemy_panel.enemy.add_target(target_panel.player)
	
func _get_corner_point(node: Container, side: String):
	var rect: Rect2 = node.get_global_rect()
	if side == "right":
		return Vector2(rect.position.x, rect.get_center().y)
	elif side == "left":
		return Vector2(rect.end.x, rect.get_center().y)
	else:
		return Vector2(0, 0)

func attack_enemy(enemy_pos: int, enemy_panel: EnemyPanel):
	for p in self.players_panels:
		if p.dice_clicked:
			var die = p.player.attack(enemy_panel.enemy)
			if die:
				self.game.enemies.erase(enemy_pos)
				enemy_panel.destroy()
			else:
				enemy_panel.update_health()
			
			p.unselect()
			p.disabled()

func _on_Done_pressed():
	print("Done")
