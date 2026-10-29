extends CharacterBody2D
@export var move_speed: float = 50
@export var move_distance: float = 20
@export var Max_HP: int = 20
@export var damage: int = 5

var current_HP: int
var start_x: float
var direction: float = 1.0
var can_damage: bool = true
var can_turn: bool = true

@onready var hp_bar: TextureProgressBar = $CommonEnemyHP
@onready var sprite = $AnimatedSprite2D
@onready var FloorCheck: RayCast2D = $FloorCheck

func _ready() -> void:
	start_x = global_position.x
	current_HP = Max_HP
	hp_bar.max_value = Max_HP
	hp_bar.value = current_HP
	
func _physics_process(delta: float) -> void:
	FloorCheck.target_position = Vector2(5 * direction, 6)
	FloorCheck.force_raycast_update()
	velocity.x = direction * move_speed
	move_and_slide()
	
	if can_turn and (!FloorCheck.is_colliding() or is_on_wall()):
		can_turn = false
		direction *= -1.0
		sprite.flip_h = direction < 0
		await get_tree().create_timer(0.2).timeout
		can_turn = true
	
	
func take_damage(amount: int, damage_source_position: Vector2 = Vector2.ZERO) -> void:
	current_HP = max(0, current_HP-amount)
	hp_bar.value=current_HP
	if current_HP<=0:
		die()

func die() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_damage:
		if body.has_method("take_damage"):
			body.take_damage(damage, global_position)

func start_damage_cooldown() -> void:
	can_damage = false
	await get_tree().create_timer(0.6).timeout
	can_damage = true
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("player"):
			_on_area_2d_body_entered(body)
