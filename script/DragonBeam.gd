
extends Area2D

@export var beam_length: float = 1200.0
@export var beam_width: float = 50.0
@export var damage: float = 20.0
@export var duration: float = 0.8

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var line: Line2D = $Line2D

var boss: Node2D
var hit_registered := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func setup(boss_node: Node2D, direction: Vector2) -> void:

	boss = boss_node

	global_rotation = direction.angle()

	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2(beam_length, 0))

	line.width = beam_width

	var rectangle = RectangleShape2D.new()
	rectangle.size = Vector2(beam_length, beam_width)

	collision.shape = rectangle
	collision.position = Vector2(beam_length / 2.0, 0)


func activate() -> void:

	monitoring = true
	collision.set_deferred("disabled", false)

	await get_tree().create_timer(duration).timeout

	queue_free()


func _on_body_entered(body: Node2D) -> void:

	if not body.is_in_group("player"):
		return

	if hit_registered:
		return

	hit_registered = true

	if body.has_method("take_damage"):
		body.take_damage(damage, global_position)

	if is_instance_valid(boss):
		boss.on_beam_hit(body)
