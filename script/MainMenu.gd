extends Control 

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/game.tscn")

#func option belum ditambahin

func _on_button_3_pressed() -> void:
	get_tree().quit()
