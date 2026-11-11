extends Node2D

var bullet_scene = preload("res://scenes/entities/bullet.tscn")

func _on_player_shoot(pos, dir):
	var bullet = bullet_scene.instantiate() as Node2D
	$Bullets.add_child(bullet)
	bullet.setup(pos, dir)
	#print(pos)
	#print(dir)
