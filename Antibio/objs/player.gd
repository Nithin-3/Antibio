extends CharacterBody2D
@export var SPEED = 450.0
@export var JUMP_VELOCITY = -750.0
var HEALTH = 100.0 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bullet = preload("res://objs/bullet.tscn")
var ang:Vector2 = Vector2.ZERO
var left = false
var right = false
func  _ready():
	$HealthBar2D.value = HEALTH
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("left", "right")
	if(direction == -1 or left):
		get_node("Sprite2D").rotation_degrees -= 3
	if(direction == 1 or right):
		get_node("Sprite2D").rotation_degrees += 3
	if direction:
		velocity.x = direction * SPEED
	elif left:
		velocity.x = -1 * SPEED
	elif right:
		velocity.x = 1 * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	if Input.is_action_just_pressed("fire1"):
		ang = (get_global_mouse_position() - position).normalized()
		$Aim.clear_points()
		var direct = global_position.direction_to(get_global_mouse_position())
		$Marker2D.position = direct*80
		for add in range(60,300):
			$Aim.add_point(direct * add)
	if Input.is_action_just_pressed("fire2") and ang != Vector2.ZERO:
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
		$Aim.queue_free()
	elif HEALTH < 30:
		$HealthBar2D.tint_progress = Color.RED
	elif HEALTH < 50:
		$HealthBar2D.tint_progress = Color.ORANGE
	else :
		$HealthBar2D.tint_progress = Color.GREEN

func heal(value):
	if HEALTH < 100-value:
		HEALTH += value
	else :
		HEALTH = 100
	if HEALTH < 30:
		$HealthBar2D.tint_progress = Color.RED
	elif HEALTH < 50:
		$HealthBar2D.tint_progress = Color.ORANGE
	else :
		$HealthBar2D.tint_progress = Color.GREEN
	$HealthBar2D.value = HEALTH



func _on_left_pressed():
	left = true
func _on_right_pressed():
	right = true
func _on_jump_pressed():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func _on_pause_pressed():
	get_tree().paused = true

func _on_bullet_pressed():
	if ang != Vector2.ZERO:
		var fir = bullet.instantiate() as Area2D
		fir.position = $Marker2D.global_position
		fir.rotation_degrees = rad_to_deg(ang.angle()) + 90
		fir.dir = ang
		$"..".add_child(fir)


func _on_left_released():
	left = false


func _on_right_released():
	right = false
