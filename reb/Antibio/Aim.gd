extends Node2D
@onready var bg = $Bg
@onready var touch = $Bg/touch
@onready var rad = 118
var pres = false
signal direct(DIR:Vector2)
func _input(event):
	if event is InputEventScreenTouch:
		var dist = event.position.distance_to(bg.global_position)
		if not pres:
			if dist < rad:
				pres = true
		else :
			touch.position = Vector2.ZERO
			pres = false
func _process(_delta):
	if pres:
		touch.global_position = get_global_mouse_position()
		if touch.position.distance_to(Vector2(0,0)) > rad:
			touch.position = touch.position.direction_to(Vector2(0,0)) * -(rad+300)
		direct.emit(-1*(touch.position.direction_to(bg.position)))
