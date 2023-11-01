extends CharacterBody2D
var spred:bool = true
var HEALTH:float = 100.0
var MUTATION:int = 100.0
var span = preload("res://objs/spans.tscn")
#var explosion = preload("res://explotion.tscn")

var rand:Vector2 = Vector2(randf_range(-1,1),randf_range(-1,1))
func _ready():
	$Timer.start()
	$Connect.Target = self
func _process(_delta):
	$Connect.cont($Connect.Target.global_position)
	if "MUTATION" in $Connect.Target:
		if $Connect.Target.MUTATION > MUTATION:
			MUTATION += 10 * _delta
	if spred:
		rand = Vector2(randf_range(-1,1),randf_range(-1,1))
		spred = false
		$Timer.start()
		var objs = span.instantiate()
		objs.position = global_position
		$"..".add_child(objs)
	if position.distance_to($"../Player1".position) < 600 and position.distance_to($"../Player1".position) > 110 :
		$Sprite2D.look_at($"../Player1".position)
		position += ($"../Player1".position - position)/500
		move_and_slide()
	else :
		position += rand * 3
		move_and_slide()
func minus(val:int,force:float):
	HEALTH -= val
	position -= global_position.direction_to($"../Player1".position) * force 
	$HealthBar2D.value = HEALTH
	if HEALTH <=0 :
		queue_free()
func _on_timer_timeout():
	spred = true
