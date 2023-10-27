extends CharacterBody2D
var bact_spreed = preload("res://objs/spans.tscn")
var spre: bool = true
func  _process(_delta):
	if spre:
		spre =false
		var node = bact_spreed.instantiate()
		add_child(node)
		move_child(node,0)
		node.rotation_degrees = randf_range(1,359)
		$Timer.start()


func _on_timer_timeout():
	spre = true

func _on_enemy_connection_body_entered(body):
	print(body)
