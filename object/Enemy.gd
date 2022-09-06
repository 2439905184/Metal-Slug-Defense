extends KinematicBody2D

var type = "Enemy"
var life = 8
enum actions {idle,walk,attack,die}
var current_action = actions.walk
onready var anim = $AnimatedSprite
var speed = 20

func _process(delta):
	if life <= 0:
		current_action = actions.die
	match current_action:
		actions.walk:
			anim.play("walk")
			move_and_slide(Vector2(-speed,0))
		actions.die:
			queue_free()
			pass
	pass
	
func hurt():
	$AnimationPlayer.play("hurt")
	life -= 1
	pass
	
func _on_Enemy_body_entered(body):
	if "Bullet" in body.name:
		$AnimationPlayer.play("hurt")
		body.queue_free()
		pass
	pass
