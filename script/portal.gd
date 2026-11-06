extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var game = get_tree().current_scene
		var next_level = game.current_level + 1 
		game.call_deferred("change_level", next_level, body)
