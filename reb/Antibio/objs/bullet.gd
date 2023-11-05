extends Area2D
@export var speed : int  = 500
var dir = Vector2.UP
var explosion = preload("res://explosion.tscn")
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
	var explo = explosion.instantiate()
	explo.position = get_global_position()
	get_tree().get_root().add_child(explo)
	explo.get_node("AnimationPlayer").play("Explon")
	if "minus" in body:
		body.minus(6,2)
	destroy()
