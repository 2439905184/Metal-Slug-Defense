extends KinematicBody2D
var speed = 64
func _process(delta):
	move_and_slide(Vector2(0,speed))
	pass
