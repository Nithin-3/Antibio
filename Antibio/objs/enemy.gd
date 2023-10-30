extends CharacterBody2D
signal line(tar:Vector2)
var HEALTH = 100
var spre: bool = true
var bact = preload("res://objs/spans.tscn")
func  _process(_delta):
	if spre:
		spre = false
		var noad = bact.instantiate()
		noad.position = global_position
		get_parent().add_child(noad)
		$Timer.start()
	var player = $"../Player"
	if global_position.distance_to($"../Player".position) < 600 and global_position.distance_to($"../Player".position) > 6 :
		var motion = Vector2()
		position += (player.position - position)/100
		look_at(player.position)

		move_and_collide(motion)
func minus(val:int):
	HEALTH -= val
	if HEALTH <= 0:
		queue_free()
		


func _on_timer_timeout():
	spre = true
