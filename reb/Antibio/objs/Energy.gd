extends Area2D

var HEAL:int = 5
var Gravity:Vector2 = Vector2.DOWN
func _on_body_entered(body):
	if "heal" in body:
		body.heal(HEAL)
		queue_free()
	if str(body)[0] != "E" and str(body)[0].to_lower() != "b":
		Gravity *= 0

func _on_timer_timeout():
	queue_free()

func _process(delta):
	position += Gravity * 50 * delta
