extends CanvasLayer



func _on_pause_pressed():
	$ColorRect.visible = true
	get_tree().paused = true

func _on_resume_pressed():
	$ColorRect.visible = false
	get_tree().paused = false
