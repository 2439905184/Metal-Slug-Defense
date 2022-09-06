extends KinematicBody2D

var speed = 60
var shoot = false

func _ready():
	shoot = true
	add_collision_exception_with(self)
	pass

func _process(delta):
	if shoot:
		move_and_slide(Vector2(-speed,0))
	pass
	
func shoot():
	
	pass
