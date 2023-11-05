extends Button



func _on_pressed():
	get_tree().change_scene_to_file("res://intro_1.tscn")


func _on_quit_pressed():
	get_tree().quit()
