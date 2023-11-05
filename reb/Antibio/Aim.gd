extends TouchScreenButton
@onready var bg = $Bg
@onready var touch = $touch
@onready var rad = 118
var pres = false
signal direct(DIR:Vector2)
func _process(_delta):
	if pres:
		touch.global_position = get_global_mouse_position()
		if touch.position.distance_to(Vector2(0,0)) > rad:
			touch.position = touch.position.direction_to(Vector2(0,0)) * -(rad)
		direct.emit(-1*(touch.position.direction_to(bg.position)))
	else :
		touch.position = bg.position
		


func _on_button_button_down():
	pres = true

func _on_button_button_up():
	pres = false
