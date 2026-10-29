extends Area2D

@export var speed: int = 400
var direction: float = 1.0

func _physics_process(delta: float) -> void:
	position.x += speed*direction*delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and not body.is_in_group("player"):
		body.take_damage(10, global_position)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
