extends Area2D

@export var speed : int  = 50
var rand:Vector2 = Vector2(randf_range(-1,1),randf_range(-1,1))
func destroy():
	visible = false
	$AudioStreamPlayer2D.play()
func _ready():
	rotation_degrees = randf_range(0,359)
	$Timer.start()
func _physics_process(delta):
	position += rand * delta * speed

func _on_timer_timeout():
	queue_free()
	
func minus(_val:int,_force:float):
	destroy()

func _on_audio_stream_player_2d_finished():
	queue_free()


func _on_body_entered(body):
	if str(body)[0] == "B":
		body.get_parent().destroy()
		destroy()
	if "minu" in body:
		body.minu(0.5)
		destroy()
	
