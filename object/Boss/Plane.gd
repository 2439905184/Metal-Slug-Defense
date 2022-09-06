extends KinematicBody2D

var move = false
var speed = 20

func _ready():
	move = true
	pass

func _process(delta):
	if move:
		move_and_slide(Vector2(-speed,-speed))
	pass

func _on_Timer_timeout():
	
#	$Plane/ball.set_as_toplevel(true)
#	$Plane/ball.position = self.global_position + Vector2(0,100)
	$Plane/ball.move = true
	#$Plane/ball.set_notify_local_transform(false)
	#$Plane/ball.set_notify_transform(false)
	print_debug("下落")
	pass
