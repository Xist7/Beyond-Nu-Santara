extends Area2D

@export var speed: int = 400
@export var damage: int = 10
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.has_method("take_damage"):
			body.take_damage(damage, global_position)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
