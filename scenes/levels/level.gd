extends Node2D

var bullet_scene = preload("res://scenes/entities/bullet.tscn")

func _ready() -> void:
	var light_tween = create_tween()
	light_tween.set_loops()
	light_tween.tween_property($Light/PointLight2D2, "energy", 1.1, 1)
	light_tween.tween_property($Light/PointLight2D2, "energy", 0.5, 1)

func _on_player_shoot(pos, dir):
	var bullet = bullet_scene.instantiate() as Node2D
	$Bullets.add_child(bullet)
	bullet.setup(pos, dir)
	#print(pos)
	#print(dir)
