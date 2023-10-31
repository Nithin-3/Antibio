extends Line2D
var line:Array
func _on_area_2d_body_entered(body):
	if str(body).to_lower()[0] =='e':
		clear_points()
		var from = global_position
		var point:Vector2 = global_position
		for add in global_position.distance_to(body.global_position):
			point += (from - body.global_position)/100
			line.push_front(point)
		for points in line:
			add_point(points)


func _on_area_2d_body_exited(body):
	if str(body).to_lower()[0] =='e':
		clear_points()

