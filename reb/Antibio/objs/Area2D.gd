extends Area2D

@export var speed : int  = 50
var rand:Vector2 = Vector2(randf_range(-1,1),randf_range(-1,1))

var spawnExplo = preload("res://spawn_enem_blast.tscn")
var live:bool = true
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

func _on_body_entered(body):
	if str(body)[0] == "B" and live:
		live = false
		var SpwnExplo = spawnExplo.instantiate()
		SpwnExplo.position = get_global_position()
		get_tree().get_root().add_child(SpwnExplo)
		SpwnExplo.get_node("AnimationPlayer").play("DeadBlast")
		body.get_parent().destroy()
		$"..".SCORE += 2.5
		$"../CanvasLayer/Score".text = "Score "+str(get_parent().SCORE)
		destroy()
	if "minus" in body:
		body.minus(0.5)
		destroy()
	if str(body)[0] != "E":
		rand = -rand + global_position.direction_to(body.position)


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
