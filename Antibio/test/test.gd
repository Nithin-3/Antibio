extends Node2D
var bullet = preload("res://objs/bullet.tscn")
func _on_player_1_bullet(po, ang):
	var fir = bullet.instantiate() as Area2D
	fir.position = po
	fir.rotation_degrees = rad_to_deg(ang.angle()) + 90
	fir.dir = ang
	add_child(fir)
