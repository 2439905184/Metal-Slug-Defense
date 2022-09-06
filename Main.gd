extends Node2D

func _ready():
	$AnimationPlayer.play("TapScreen")
	pass

func _input(event):
	if event is InputEventScreenTouch:
		get_tree().change_scene("res://Menu.tscn")
	pass
