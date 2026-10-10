extends CharacterBody2D

@export var move_speed: float = 100.0
@export var move_distance: float = 120.0
@export var Max_HP_boss: int = 100

var current_HP: int
var start_x: float
var direction: float = 1.0

@onready var hp_bar: TextureProgressBar = $Boss1HP

func _ready() -> void:
	start_x = global_position.x
	current_HP = Max_HP_boss
	hp_bar.max_value = Max_HP_boss
	hp_bar.value = current_HP

func _physics_process(delta: float) -> void:
	velocity.x = direction * move_speed
	move_and_slide()
	if is_on_wall():
		direction *= -1.0

func take_damage(amount: int, damage_source_position: Vector2 = Vector2.ZERO) -> void:
	current_HP = max(0, current_HP-amount)
	hp_bar.value=current_HP
	
	if current_HP<=0:
		die()

func die() -> void:
	queue_free()
	
