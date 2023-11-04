extends Node2D
var LEVEL = 1
@export var ENEMYS_COUNT:int = 0
@export var KILLS:int = 0
var ENEMY_NODE = preload("res://objs/enemy.tscn")


func _ready():
	lev_strt(1)


func lev_strt(level):
	print(level)
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
	var node = ENEMY_NODE.instantiate()
	node.position = Vector2(randi_range(-800,3000),randi_range(450,-1300))
	node.MUTATION = 100*(level+1)
	add_child(node)
	for enmy in enmy_count:
		var nodes = ENEMY_NODE.instantiate()
		nodes.position = Vector2(randi_range(-800,3000),randi_range(450,-1300))
		add_child(nodes)
	ENEMYS_COUNT += enmy_count

func _process(_delta):
	if (float(KILLS)/float(ENEMYS_COUNT))*100 >= 70.0:
		LEVEL += 1
		lev_strt(LEVEL) 
