extends Node2D
var LEVEL = 1
@export var ENEMYS_COUNT:int = 0
@export var KILLS:int = 0
var enemy = preload("res://objs/enemy.tscn")
var player_2 =preload("res://asset/player/Player2.png")
var player_3 = preload("res://asset/player/Player3.png")
func _ready():
	lev_strt(1)


func lev_strt(level):
	if level == 3:
		$Player/Sprite2D.texture = player_2
	if level == 4:
		$Player/Sprite2D.texture = player_3
	var enmy_count = 0
	if (level == 1): 
		enmy_count = 10 
	elif level == 2:
		enmy_count = 15
	elif level == 3:
		enmy_count = 20
	elif level == 4:
		enmy_count = 25
	else:
		enmy_count = 30
	if level > 5:
		get_tree().paused = true
		$CanvasLayer/GameEnd.visible = true
		return
	var node = enemy.instantiate()
	node.MUTATION = 100 * (level+1)
	node.position = Vector2(randi_range(-930,10890),randi_range(450,-2130))
	node.mutat()
	add_child(node)
	for enmy in enmy_count:
		var nodes = node.duplicate()
		nodes.MUTATION = 100 
		nodes.name = 'e'+str(enmy)
		nodes.position = Vector2(randi_range(-930,10890),randi_range(450,-2130))
		add_child(nodes)
	ENEMYS_COUNT += enmy_count
	$CanvasLayer/Timer.start()
	$CanvasLayer/ColorRect.visible = true
	$CanvasLayer/ColorRect/Label.text = "LEVEL "+str(level)
func _process(_delta):
	if (float(KILLS)/float(ENEMYS_COUNT))*100 >= 70.0:
		LEVEL += 1
		lev_strt(LEVEL) 

func _on_timer_timeout():
	$CanvasLayer/ColorRect.visible = false


func _on_home_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu.tscn")
