extends Node2D


var current_level = 2

func _ready():
	show_level(2)

func show_level(level):
	$Level1.visible = false
	$Level2.visible = false
	$Level3.visible = false
	$Level4.visible = false
	$Level5.visible = false
	
	if level == 1:
		$Level1.visible = true
	if level == 2:
		$Level2.visible = true
	if level == 3:
		$Level3.visible = true
	if level == 4:
		$Level4.visible = true
	if level == 5:
		$Level5.visible = true
		
func show_death_menu():
	$DeathMenu/Menu.visible = true

func _on_button_pressed() -> void:
	$DeathMenu/Menu.visible = false
	$Player.respawn()
	$Player.set_physics_process(true)

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/Main menu.tscn")
