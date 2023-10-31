extends CharacterBody2D
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500.0
var HEALTH = 100.0 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Animation
@onready var anim = get_node("AnimationPlayer")
signal bullet(po:Vector2,ang)
func  _ready():
	anim.play("Idle")
	$HealthBar2D.value = HEALTH
func _physics_process(delta):
#	look_at(get_global_mouse_position())
	if not is_on_floor():
		#get_node("AnimationPlayer").play("Jump3")
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		anim.play("Jump3")
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("left", "right")
	
	if(direction == -1):
		get_node("AnimatedSprite2D").flip_h = true
	if(direction == 1):
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		if(velocity.y == 0):
			anim.play("Run")
		
		velocity.x = direction * SPEED
	else:
		anim.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	if Input.is_action_just_pressed("fire1"):
		bullet.emit($Marker2D.global_position,(get_global_mouse_position() - position).normalized())
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
