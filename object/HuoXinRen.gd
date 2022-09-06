extends KinematicBody2D

var cost = 50
var speed = 20

var move = false

enum actions {move,attack}
var current_action = actions.move

var attack_target 

onready var ray = $RayCast2D
onready var Bullet = load("res://object/Bullet.tscn")

func _ready():
	#move = true
	$AnimatedSprite.play("walk")
	$AnimatedSprite.connect("animation_finished",self,"_on_anim_finish")
	
func _process(delta):
	
	$ProgressBar.value = -$Skill.time_left
	if ray.is_colliding():
		attack_target = ray.get_collider()
		#print_debug(attack_target)
		if attack_target.name == "Enemy":
			current_action = actions.attack
	match current_action:
		actions.attack:
			attack()
		actions.move:
			move_and_slide(Vector2(speed,0))
		#$AnimatedSprite.play("attack")
	pass


func _on_Bing1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_mask == BUTTON_LEFT:
		move = false
		$ProgressBar.value = -2
		$AnimatedSprite.play("skill")
		
	pass

func attack():
	$Timer.start()
	for i in 3:
		var b = Bullet.instance()
		yield($Timer,"timeout")
		add_child(b)
		
	pass
func _on_anim_finish():
#	var anim = $AnimatedSprite.animation
#	print_debug(anim)
#	if anim == "skill":
#		move = true
#		current_action = actions.move
#		$AnimatedSprite.play("walk")
#		$Skill.start()
#	if anim == "attack":
#		if attack_target.name == "DoorEnemy":
#			attack_target.emit_signal("life_down")
	pass
