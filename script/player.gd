extends CharacterBody2D


const SPEED = 160.0
const JUMP_VELOCITY = -400.0

@export var MAX_HP_PLAYER: int = 50
var last_direction: float = 0.0
var CURRENT_HP_PLAYER: int

@onready var spawn_point: Vector2 = global_position
func _ready() -> void:
	CURRENT_HP_PLAYER = MAX_HP_PLAYER
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# Last pressed direction wins when both are held.
	if Input.is_action_just_pressed("move_left"):
		last_direction = -1.0
	elif Input.is_action_just_pressed("move_right"):
		last_direction = 1.0

	var left := Input.is_action_pressed("move_left")
	var right := Input.is_action_pressed("move_right")
	var direction := 0.0
	if left and right:
		direction = last_direction
	elif left:
		direction = -1.0
	elif right:
		direction = 1.0

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func take_damage(amount: int) -> void:
	CURRENT_HP_PLAYER -= amount
	if CURRENT_HP_PLAYER <= 0:
		die()

func die() -> void:
	print("You died")
	respawn()

func respawn() -> void:
	CURRENT_HP_PLAYER = MAX_HP_PLAYER
	velocity = Vector2.ZERO
	global_position = spawn_point
	print("You Respawn")
	
