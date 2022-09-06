extends KinematicBody2D
var placed = false
# 走 放 逃 死
enum actions {walk,place,tao,die}
var current_actin = actions.walk
var speed = 60
onready var ray = $RayCast2D
onready var anim = $AnimatedSprite
onready var ShaBao = load("res://object/ShaBao.tscn")
var type = "friend"

func _ready():
	
	pass
	
func _process(delta):
	if ray.is_colliding() and not placed:
		current_actin = actions.place
	match current_actin:
		actions.walk:
			anim.play("walk")
			move_and_slide(Vector2(speed,0))
		actions.place:
			do_place()
		actions.tao:
			anim.play("walk")
			move_and_slide(Vector2(-speed,0))
			
# 放动画
func do_place():
	anim.play("place")
	pass
	
# 放下沙包
func place():
	var shabao = ShaBao.instance()
	shabao.position = ray.get_collision_point()
	get_tree().current_scene.add_child(shabao)
	pass
	
func _on_AnimatedSprite_animation_finished():
	match anim.animation:
		"place":
			place()
			current_actin = actions.tao
			anim.flip_h = true
			placed = true
	pass 

func _on_VisibilityNotifier2D_screen_exited():
	print_debug("矿工逃离边界，自动释放")
	self.queue_free()
	pass


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	print_debug("矿工逃离边界，自动释放")
	pass # Replace with function body.
