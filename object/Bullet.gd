extends KinematicBody2D

var speed = 50

func _ready():
	add_collision_exception_with(self)
	pass

func _process(delta):
	move_and_slide(Vector2(speed,0))
	pass
