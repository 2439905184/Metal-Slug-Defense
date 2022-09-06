extends Node2D

onready var XiaoBing = load("res://object/Bing1.tscn")
onready var HuoXingRen = load("res://object/HuoXinRen.tscn")
onready var AP = $AP
onready var KuangGong = load("res://object/KuangGong.tscn")

func _ready():
	$AnimationPlayer.play("Mission")
	

func openDoorAnim():
	$Door.play("open")
	$DoorEnemy/Sprite.play("open")
	pass
	
func _on_XiaoBing_pressed():
	if AP.ap > 30:
		AP.ap -= 30
		var bing = XiaoBing.instance()
		bing.position = $Position2D.position
		add_child(bing)
	pass

func _on_DoorEnemy_life_down():
	$TargetLift.value -= 5
	if $TargetLift.value <= 0:
		$Back.show()
		$Win.show()
		get_tree().paused = true
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Mission":
		openDoorAnim()
	pass

func _on_HuoXinRen_pressed():
	if AP.ap >= 50:
		AP.ap -= 50
		var hx = HuoXingRen.instance()
		hx.position = $Position2D.position
		add_child(hx)
	pass 

func _on_KuangGong_pressed():
	if AP.ap >= 40:
		AP.ap -= 40
		var kg = KuangGong.instance()
		kg.position = $Position2D.position
		add_child(kg)
	pass

func _on_Back_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://LevelSelect.tscn")
	pass
