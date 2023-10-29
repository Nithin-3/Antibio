extends CharacterBody2D
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
signal bullet(po:Vector2,ang)
func _physics_process(delta):
#	look_at(get_global_mouse_position())
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	if Input.is_action_just_pressed("fire1"):
		bullet.emit($Marker2D.position,(get_global_mouse_position() - position).normalized())
