extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var game = get_tree().current_scene
		game.call_deferred("change_level", 2, body)
