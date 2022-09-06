extends Label


var ap = 100

func _on_Timer_timeout():
	ap += 1
	self.text = "AP:" + str(ap) + "/0100"
	pass
