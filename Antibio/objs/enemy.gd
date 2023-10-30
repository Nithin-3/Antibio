extends CharacterBody2D
signal line(tar:Vector2)
var HEALTH = 100
var spre: bool = true
func  _process(_delta):
	var player = $"../Player"
	if global_position.distance_to($"../Player".position) < 600 :
		var motion = Vector2()

		position += (player.position - position)/100
		look_at(player.position)

		move_and_collide(motion)
func minus(val:int):
	HEALTH -= val
	if HEALTH <= 0:
		queue_free()
		
