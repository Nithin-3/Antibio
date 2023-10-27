extends Area2D

@export var speed : int  = 50
var rand:Vector2 = Vector2(randf_range(-1,1),randf_range(-1,1))
func _ready():
	rotation_degrees = randf_range(0,359)
	$Timer.start()
func _physics_process(delta):
	position += rand * delta * speed

func _on_timer_timeout():
	$AudioStreamPlayer2D.play()
	


func _on_audio_stream_player_2d_finished():
	queue_free()
