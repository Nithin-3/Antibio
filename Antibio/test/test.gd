extends Node2D

var from:Vector2 
var to:Vector2 

# Called when the node enters the scene tree for the first time.
func _ready():
	from = $Enemy.position
	to = $Enemy.position

func _on_enemy_line(tar):
	to = tar
	from = $Enemy.position
	queue_redraw()
func  _draw():
	draw_line(from,to,Color.GREEN,1)
	
