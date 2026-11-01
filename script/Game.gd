extends Node2D


var current_level = 1

func _ready():
	show_level(1)
	$DeathMenu/Menu.visible = false

func show_level(level):
	$Level1.visible = false
	$Level1.process_mode = Node.PROCESS_MODE_DISABLED
	$Level1/TileLayer.set_deferred("collision_enabled", false)
	
	$Level2.visible = false
	$Level2.process_mode = Node.PROCESS_MODE_DISABLED
	$Level2/TileLayer.set_deferred("collision_enabled", false)
	
	$Level3.visible = false
	$Level3.process_mode = Node.PROCESS_MODE_DISABLED
	$Level3/TileLayer.set_deferred("collision_enabled", false)
	
	$Level4.visible = false
	$Level4.process_mode = Node.PROCESS_MODE_DISABLED
	$Level4/TileLayer.set_deferred("collision_enabled", false)
	
	$Level5.visible = false
	$Level5.process_mode = Node.PROCESS_MODE_DISABLED
	$Level5/TileLayer.set_deferred("collision_enabled", false)
	
	if level == 1:
		$Level1.visible = true
		$Level1.process_mode = Node.PROCESS_MODE_INHERIT
		$Level1/TileLayer.set_deferred("collision_enabled", true)
		
	if level == 2:
		$Level2.visible = true
		$Level2.process_mode = Node.PROCESS_MODE_INHERIT
		$Level2/TileLayer.set_deferred("collision_enabled", true)
		
	if level == 3:
		$Level3.visible = true
		$Level3.process_mode = Node.PROCESS_MODE_INHERIT
		$Level3/TileLayer.set_deferred("collision_enabled", true)
		
	if level == 4:
		$Level4.visible = true
		$Level4.process_mode = Node.PROCESS_MODE_INHERIT
		$Level4/TileLayer.set_deferred("collision_enabled", true)
		
	if level == 5:
		$Level5.visible = true
		$Level5.process_mode = Node.PROCESS_MODE_INHERIT
		$Level5/TileLayer.set_deferred("collision_enabled", true)

func change_level(level: int, player: Node2D):
	show_level(level)
	var spawn = get_node("Level" + str(level) + "/SpawnPoint")
	player.global_position = spawn.global_position
	player.spawn_point = spawn.global_position

func show_death_menu():
	$DeathMenu/Menu.visible = true

func _on_button_pressed() -> void:
	$DeathMenu/Menu.visible = false
	$Player.respawn()
	$Player.set_physics_process(true)

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/Main menu.tscn")
