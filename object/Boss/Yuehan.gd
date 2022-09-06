extends KinematicBody2D
# 中立 近程 远程 特殊
enum actions {idle,short_attack,long_attack,special_attack}
var current_action = actions.idle
onready var zhuazi = $zhuazi
onready var ball = load("res://object/ball.tscn")
onready var gouzi = $Gouzi
onready var gouziTimer = $Gouzi/GouziTimer
onready var DaoDan = load("res://object/Boss/DaoDan.tscn")
onready var hand = $hand
func _ready():
	#zhuazi_attack()
	#long_attack()
	short_attack()
	pass
	
func short_attack():
	current_action = actions.short_attack
	hand.play("open")
	
	pass
	
func long_attack():
	var d = DaoDan.instance()
	d.shoot = true
	d.position = $hand.position
	#$hand/DaoDan.shoot = true
	add_child(d)
	pass
	
func special_attack():
	$zhuazi.translate(Vector2(64,0))
	var ball_instance = ball.instance()
	ball_instance.position = zhuazi.position
	add_child(ball_instance)
	pass

func zhuazi_attack():
	gouzi.get_node("GouziTween").interpolate_property(gouzi,"position",gouzi.position,gouzi.position + Vector2(0,115),1,Tween.TRANS_LINEAR)
	gouzi.get_node("GouziTween").start()
	
func _on_zhuazi_animation_finished():
	match zhuazi.animation:
		"shoot":
			special_attack()
			pass
	pass
	
var tween_times = 0
func _on_GouziTween_tween_all_completed():
	gouzi.frame = 1
	if tween_times != 1:
		gouziTimer.start()
	else:
		gouzi.get_node("GouziTween").stop_all()
	tween_times += 1
	pass


func _on_GouziTimer_timeout():
	gouzi.get_node("GouziTween").interpolate_property(gouzi,"position",gouzi.position,gouzi.position - Vector2(0,115),1,Tween.TRANS_LINEAR)
	gouzi.get_node("GouziTween").start()
	pass


func _on_hand_animation_finished():
	if hand.animation == "open" and current_action == actions.short_attack:
		
		pass
	pass
