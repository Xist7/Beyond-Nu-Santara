extends Node2D


var current_level = 2

func _ready():
	show_level(2)

func show_level(stage):
	$Level1.visible = false
	$Level2.visible = false
	$Level3.visible = false
	$Level4.visible = false
	$Level5.visible = false
	
	if stage == 1:
		$Level1.visible = true
	if stage == 2:
		$Level2.visible = true
	if stage == 3:
		$Level3.visible = true
	if stage == 4:
		$Level4.visible = true
	if stage == 5:
		$Level5.visible = true
