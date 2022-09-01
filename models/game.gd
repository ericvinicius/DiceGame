class_name GamePhase

var players: Array[Player]
var enemies: Array[Enemy]
var difficult: int
var rows_remaining: int
var done_clicked: bool

func _init(players: Array[Player], enemies: Array[Enemy], difficult: int = 1, rows_remaining: int = 3, done_clicked: bool = false):
	self.players = players
	self.enemies = enemies
	self.difficult = difficult
	self.rows_remaining = rows_remaining
	self.done_clicked = done_clicked
