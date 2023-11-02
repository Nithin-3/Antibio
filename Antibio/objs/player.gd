extends CharacterBody2D
@export var SPEED = 450.0
@export var JUMP_VELOCITY = -650.0
var HEALTH = 100.0 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bullet = preload("res://objs/bullet.tscn")
var ang:Vector2
func  _ready():
	$HealthBar2D.value = HEALTH
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if(direction == -1):
		get_node("Sprite2D").rotation_degrees -= 3
	if(direction == 1):
		get_node("Sprite2D").rotation_degrees += 3
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	
	if Input.is_action_just_pressed("fire1"):
		ang = (get_global_mouse_position() - position).normalized()
		$Aim.clear_points()
		var direct = global_position.direction_to(get_global_mouse_position())
		$Marker2D.position = direct*80
		for add in range(60,1000):
			$Aim.add_point(direct * add)
	if Input.is_action_just_pressed("fire2"):
		var fir = bullet.instantiate() as Area2D
		fir.position = $Marker2D.global_position
		fir.rotation_degrees = rad_to_deg(ang.angle()) + 90
		fir.dir = ang
		$"..".add_child(fir)
func minus(val:float):
	HEALTH -= val
	$HealthBar2D.value = HEALTH
	if HEALTH <=0 :
		get_tree().paused = true
	elif HEALTH < 30:
		$HealthBar2D.tint_progress = Color.RED
	elif HEALTH < 50:
		$HealthBar2D.tint_progress = Color.ORANGE
	else :
		$HealthBar2D.tint_progress = Color.GREEN
