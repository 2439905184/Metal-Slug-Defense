extends KinematicBody2D

var speed = 30
# 移动 近战 远战
enum actions {move,attack,long_attack}
var current_action = actions.move
# 攻击的对象
var attack_target 
var type = "friend"
onready var ray = $RayCast2D
onready var anim = $AnimatedSprite
onready var skillBar = $ProgressBar
onready var shouLiuDan = load("res://object/ShouLiuDan.tscn")
func _ready():
	anim.connect("animation_finished",self,"_on_anim_finish")

func _process(delta):
	match current_action:
		actions.move:
			anim.play("walk")
			move_and_slide(Vector2(speed,0))
		actions.attack:
			anim.play("attack")
		actions.long_attack:
			anim.play("skill")
	if ray.is_colliding():
		attack_target = ray.get_collider()
		if attack_target.type == "Enemy" or attack_target.type == "敌人据点":
			current_action = actions.attack
		#elif attack_target.type == "friend":
			#add_collision_exception_with(attack_target)
	else:
		if current_action != actions.long_attack:
			current_action = actions.move
	$ProgressBar.value = -$Skill.time_left
	
	pass

func _on_Bing1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_mask == BUTTON_LEFT:
		if skillBar.value == 0:
			skillBar.value = -2
			current_action = actions.long_attack
	pass
# 丢手榴弹
func drop_dan():
	var instance = shouLiuDan.instance()
	#instance.position = $shot.position
	$Path2D/PathFollow2D.add_child(instance)
	var tween = $Path2D/PathFollow2D/Tween
	tween.interpolate_property($Path2D/PathFollow2D,"unit_offset",0, 1, 1.0, Tween.TRANS_LINEAR)
	$Path2D/PathFollow2D/Tween.start()
	yield($Path2D/PathFollow2D/Tween,"tween_all_completed")
	if is_instance_valid(instance):
		instance.queue_free()
	pass
	
func _on_anim_finish():
	if anim.animation == "skill":
		drop_dan()
		current_action = actions.move
		anim.play("walk")
		$Skill.start()
	if anim.animation == "attack":
		#print_debug("攻击动画结束")
		if is_instance_valid(attack_target):
			if attack_target.type == "Enemy":
				attack_target.hurt()
			if attack_target.type == "敌人据点":
				attack_target.emit_signal("life_down")
				#attack_target.queue_free()
#		if attack_target.name == "DoorEnemy":
#			attack_target.emit_signal("life_down")
	pass
