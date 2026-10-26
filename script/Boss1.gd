extends CharacterBody2D

@export var move_speed: float = 120.0
@export var move_distance: float = 120.0
@export var Max_HP_boss: int = 300
@export var damage: int = 20
@export var jump_force: float = 350.0
@export var charge_speed: float = 350.0
@export var charge_duration: float = 0.8
@export var windup_duration: float = 1.0

var current_HP: int
var start_x: float
var direction: float = 1.0
var can_damage: bool = true

enum BossState { PATROL, JUMP, WINDUP, CHARGE }
var state: BossState = BossState.PATROL
var action_timer: float = 1.0
var state_timer: float = 0.0
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var hp_bar: TextureProgressBar = $Boss1HP
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	start_x = global_position.x
	current_HP = Max_HP_boss
	hp_bar.max_value = Max_HP_boss
	hp_bar.value = current_HP

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	var phase_two = current_HP <= Max_HP_boss * 0.5
	
	if not phase_two:
		state = BossState.PATROL
		velocity.x = direction * move_speed
	else:
		match state:
			BossState.PATROL:
				velocity.x = direction * move_speed
				action_timer -= delta
				if action_timer <= 0.0 and is_on_floor():
					var action = randi_range(0, 1)
					if action == 0:
						state = BossState.JUMP
						velocity.y = -jump_force
					else:
						var player = get_tree().get_first_node_in_group("player")
						if player:
							direction = sign(player.global_position.x - global_position.x)
							if direction == 0:
								direction = 1.0
						state = BossState.WINDUP
						state_timer = windup_duration

			BossState.JUMP:
				velocity.x = direction * move_speed

			BossState.WINDUP:
				velocity.x = 0.0
				sprite.pause()
				state_timer -= delta
				# kedip merah sebagai aba-aba
				sprite.modulate = Color(1, 0.4, 0.4) if int(state_timer * 10) % 2 == 0 else Color(1, 1, 1)
				if state_timer <= 0.0:
					sprite.modulate = Color(1, 1, 1)
					sprite.play()
					state = BossState.CHARGE
					state_timer = charge_duration

			BossState.CHARGE:
				velocity.x = direction * charge_speed
				state_timer -= delta
				if state_timer <= 0.0:
					state = BossState.PATROL
					action_timer = 0.8
	
	move_and_slide()
	if is_on_wall():
		if state == BossState.CHARGE:
			state = BossState.PATROL
			action_timer = 0.8
		direction *= -1.0
	
	if state == BossState.JUMP and is_on_floor() and velocity.y >= 0.0:
		state = BossState.PATROL
		action_timer = 0.8
	sprite.flip_h = direction < 0

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
