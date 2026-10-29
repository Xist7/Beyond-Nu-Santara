extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -400.0

@export var MAX_HP_PLAYER: int = 50

@onready var shoot_point: Marker2D = $Projectile
@onready var sprite = $AnimatedSprite2D
@onready var spawn_point: Vector2 = global_position
@onready var hp_bar: TextureProgressBar = $PlayerHP

var last_direction: float = 0.0
var CURRENT_HP_PLAYER: int
var can_shoot: bool = true
const KNOCKBACK_FORCE = Vector2(250, -200)
var is_knockedback : bool = false 
const Projectile_Scene_p=preload("res://scene/p_projectile.tscn")


func _ready() -> void:
	add_to_group("player")
	CURRENT_HP_PLAYER = MAX_HP_PLAYER
	
	# Set nilai awal bar HP
	hp_bar.max_value = MAX_HP_PLAYER
	hp_bar.value = CURRENT_HP_PLAYER
	
func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_knockedback:
		velocity.y = JUMP_VELOCITY

	if not is_knockedback:
		var left := Input.is_action_pressed("move_left")
		var right := Input.is_action_pressed("move_right")
		var direction := 0.0
		if left:
			direction -= 1.0
		if right:
			direction += 1.0

		# Update last_direction HANYA saat ada input
		if direction != 0.0:
			last_direction = direction
			sprite.flip_h = direction < 0

			# Posisi shoot_point berdasarkan arah hadap
			if direction > 0:
				shoot_point.position.x = -15
			else:
				shoot_point.position.x = -40
			shoot_point.position.y = -22

		# Gerakkan player
		if direction != 0.0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Shoot
		if Input.is_action_just_pressed("shoot"):
			shoot()

	# Panggil update animasi (pakai velocity.x agar akurat)
	_update_animation(abs(velocity.x) > 1.0)

	move_and_slide()
	
func _update_animation(is_moving: bool) -> void:
	if is_knockedback:
		if sprite.animation != "Idle":
			sprite.play("Idle")
		return

	if not sprite or not sprite.sprite_frames:
		return
	var target_anim := "Idle"
	if is_moving and sprite.sprite_frames.has_animation("walk"):
		target_anim = "walk"

	if not sprite.sprite_frames.has_animation(target_anim):
		return

	if sprite.animation != target_anim:
		sprite.play(target_anim)

func take_damage(amount: int, damage_source_position: Vector2) -> void:
	CURRENT_HP_PLAYER -= amount
	hp_bar.value = CURRENT_HP_PLAYER 
	apply_knockback(damage_source_position)
	if CURRENT_HP_PLAYER <= 0:
		die()

func die() -> void:
	print("You died")
	respawn()

func respawn() -> void:
	CURRENT_HP_PLAYER = MAX_HP_PLAYER
	hp_bar.value = CURRENT_HP_PLAYER # <-- Reset tampilan bar saat respawn
	velocity = Vector2.ZERO
	global_position = spawn_point
	print("You Respawn")
	
func apply_knockback(source_pos: Vector2) -> void:
	is_knockedback = true
	var direction_x = 1.2 if global_position.x < source_pos.x else -1.2
	velocity.x = KNOCKBACK_FORCE.x * -direction_x
	velocity.y = KNOCKBACK_FORCE.y
	await get_tree().create_timer(0.20).timeout
	is_knockedback = false
	
func shoot() -> void:
	if not can_shoot:
		return
	can_shoot = false
	var bullet = Projectile_Scene_p.instantiate()
	var shoot_direction = last_direction if last_direction != 0.0 else 1.0
	bullet.direction = shoot_direction
	bullet.global_position = shoot_point.global_position
	get_tree().current_scene.add_child(bullet)
	await get_tree().create_timer(0.7).timeout
	can_shoot = true
