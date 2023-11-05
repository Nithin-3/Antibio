extends CharacterBody2D
var spred:bool = true
var HEALTH:float = 100.0
@export var MUTATION:int = 100
var live:bool = true
var span = preload("res://objs/spans.tscn")
var mut:bool = true
var _1 = preload("res://asset/enemy/1.png")
var _2 = preload("res://asset/enemy/2.png")
var _3 = preload("res://asset/enemy/3.png")
var _4 = preload("res://asset/enemy/4.png")
var _5 = preload("res://asset/enemy/5.png")
var heal = preload("res://objs/Energy.tscn")
var redu = true
var rand:Vector2 = Vector2(randf_range(-1,1),randf_range(-1,1))
@onready var deathsound = $"Death-Explotion"
var blueexplon = preload("res://blue_explo.tscn")
func _ready():
	mutat()
	$Mutation.value = MUTATION
	$Timer.start()
func _process(_delta):
	if "MUTATION" in $Connect.Target and mut:
		if $Connect.Target.MUTATION > MUTATION:
			$Mut.start()
			MUTATION += 2
			$Mutation.value = MUTATION
			mutat()
			mut = false
	if spred:
		rand = Vector2(randf_range(-1,1),randf_range(-1,1))
		spred = false
		$Timer.start()
		var objs = span.instantiate()
		objs.position = global_position
		$"..".add_child(objs)
	if position.distance_to($"../Player".position) < 600 and position.distance_to($"../Player".position) > 112:
		$Sprite2D.look_at($"../Player".position)
		position += ($"../Player".position - position)/300
		move_and_slide()
	elif position.distance_to($"../Player".position) <= 160.0:
		if redu:
			redu = false
			$mins.start()
			$"../Player".minus(int(MUTATION/100))
	else :
		position += rand * 3
		move_and_slide()
	if $"../Player".HEALTH < 1:
		$Connect.visible = false
	else :
		$Connect.cont($Connect.Target.global_position)
func minus(val:int,force:float):
	HEALTH -= val/int(MUTATION/100)
	position -= global_position.direction_to($"../Player".position) * force 
	if HEALTH < 1 and  live:
		live = false
		deathsound.play()
		get_parent().KILLS += 1 
		var inc = heal.instantiate()
		inc.position = global_position
		inc.HEAL = inc.HEAL* int(MUTATION/100)
		$"..".call_deferred("add_child",inc)
		var blueexplotion = blueexplon.instantiate()
		blueexplotion.position = get_global_position()
		get_tree().get_root().add_child(blueexplotion)
		blueexplotion.get_node("AnimationPlayer").play("ExplotionBlue")
		visible = false
	$HealthBar2D.value = HEALTH
func _on_timer_timeout():
	spred = true
func _on_mut_timeout():
	mut = true
func mutat():
	if int(MUTATION/100) == 1:
		$Sprite2D.texture = _1
		$Sprite2D.scale = Vector2(0.326,0.311)
	if int(MUTATION/100) == 2:
		$Sprite2D.texture = _2
		$Sprite2D.scale = Vector2(0.468,0.47)
	if int(MUTATION/100) == 3:
		$Sprite2D.texture = _3
		$Sprite2D.scale = Vector2(0.474,0.457)
	if int(MUTATION/100) == 4:
		$Sprite2D.texture = _4
		$Sprite2D.scale = Vector2(0.302,0.302)
	if int(MUTATION/100) == 5:
		$Sprite2D.texture = _5
		$Sprite2D.scale = Vector2(0.32,0.32)


func _on_mins_timeout():
	redu = true


func _on_death_sound_finished():
	queue_free()


func _on_death_explotion_finished():
	queue_free()
