extends StaticBody2D

@export var damage_amount: int = 10  
var can_damage: bool = true

# Nama fungsi ini otomatis dibuat oleh Godot setelah Anda connect sinyal
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_damage:
		if body.has_method("take_damage"):
			body.take_damage(damage_amount, global_position)
			start_damage_cooldown()

func start_damage_cooldown() -> void:
	can_damage = false
	await get_tree().create_timer(0.6).timeout
	can_damage = true

	# Mengecek apakah player masih berdiri di atas trap setelah cooldown selesai
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("player"):
			_on_area_2d_body_entered(body)
