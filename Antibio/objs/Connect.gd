extends Line2D
var Target
func _on_area_2d_body_entered(body):
	if str(body).to_lower()[0] =='e':
		Target = body
func cont(tar:Vector2):
	clear_points()
	var point:Vector2 = position + global_position.direction_to(tar)
	var rang = global_position.distance_to(tar)
	for add in rang:
		print(add)
		if add > rang/1.8:
			break
		add_point(point*add)

func _on_area_2d_body_exited(body):
	if str(body).to_lower()[0] =='e':
		Target = self
		clear_points()

