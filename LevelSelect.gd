extends Node2D

func _on_back_pressed():
	get_tree().change_scene("res://Menu.tscn")
	pass


func _on_Stage1_pressed():
	get_tree().change_scene("res://scene/Stage1.tscn")
	pass
