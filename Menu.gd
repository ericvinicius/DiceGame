extends Control

signal signal_game_start(difficult)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_EasyButton_pressed():
	print("Easy")
	emit_signal("signal_game_start")
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.


func _on_Mediumbutton_pressed():
	print("Medium")
	emit_signal("signal_game_start", 2)
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.

