extends Area2D
@export var speed : int  = 500
var dir = Vector2.UP
func destroy():
	visible = false
	queue_free()
func _ready():
	$Timer.start()
func _physics_process(delta):
	position += dir * delta * speed

func _on_timer_timeout():
	destroy()


func _on_body_entered(body):
	if str(body)[0] != "P" and body != $StaticBody2D:
		if "minus" in body:
			body.minus(6,2)
		destroy()
