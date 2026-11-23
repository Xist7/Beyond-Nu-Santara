extends Control


signal upgrade_selected(upgrade_name: String)

var upgrades = [
	{
		"id": "max_hp",
		"name": "Vitality",
		"description": "Max HP +20 dan memulihkan 20 HP"
	},
	{
		"id": "damage",
		"name": "Heavy Bullet",
		"description": "Damage projectile +10"
	},
	{
		"id": "attack_speed",
		"name": "Rapid Fire",
		"description": "Cooldown menembak berkurang"
	},
	{
		"id": "movement_speed",
		"name": "Swift Boots",
		"description": "Movement Speed +30"
	},
	{
		"id": "heal",
		"name": "Healing",
		"description": "Memulihkan 30 HP"
	},
	{
		"id" : "jump",
		"name" : "High Jump",
		"description" : "Jump Height +100"
	}
]

var selected_upgrades: Array = []

func _ready() -> void:
	visible = false

	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	$CenterContainer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	$CenterContainer/HBoxContainer/Upgrade1.pressed.connect(
		func(): select_upgrade(0)
	)
	$CenterContainer/HBoxContainer/Upgrade2.pressed.connect(
		func(): select_upgrade(1)
	)
	$CenterContainer/HBoxContainer/Upgrade3.pressed.connect(
		func(): select_upgrade(2)
	)

func show_upgrades() -> void:
	selected_upgrades = upgrades.duplicate(true)
	selected_upgrades.shuffle()
	selected_upgrades = selected_upgrades.slice(0, 3)

	var cards = [
		$CenterContainer/HBoxContainer/Upgrade1,
		$CenterContainer/HBoxContainer/Upgrade2,
		$CenterContainer/HBoxContainer/Upgrade3
	]

	for i in range(3):
		cards[i].text = selected_upgrades[i]["name"] + "\n\n" + selected_upgrades[i]["description"]

	visible = true

func select_upgrade(index: int) -> void:
	var upgrade = selected_upgrades[index]
	upgrade_selected.emit(upgrade["id"])
