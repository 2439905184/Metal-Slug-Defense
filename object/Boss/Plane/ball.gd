extends KinematicBody2D

var move = false
var speed = 200

func _process(delta):
	if move:
		move_and_slide(Vector2(0,speed))
	pass
