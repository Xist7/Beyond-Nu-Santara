extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@export var MAX_HP_PLAYER: int = 50
var CURRENT_HP_PLAYER: int

@onready var spawn_point: Vector2 = global_position
func _ready() -> void:
	CURRENT_HP_PLAYER = MAX_HP_PLAYER
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
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
	
