extends CharacterBody2D

var direction: Vector2
var speed := 50
var player: CharacterBody2D
var hp := 3

func _on_detection_area_body_entered(player_body: CharacterBody2D) -> void:
	player = player_body

func _physics_process(_delta: float) -> void:
	if(player):
		var dir = (player.position - position).normalized()
		velocity = dir * speed
		move_and_slide()


func _on_detection_area_body_exited(_player_body: CharacterBody2D) -> void:
	player = null


func _on_collision_2d_body_entered(_body):
	explode_animation()
	
func hit():
	hp -= 1
	if hp <= 0:
		explode_animation()
	
func explode_animation():
	speed = 0
	$AnimatedSprite2D.hide()
	$ExplosoionSprite.show()
	$AnimationPlayer.play("explode")
	await  $AnimationPlayer.animation_finished
	for drone in get_tree().get_nodes_in_group('Drones'):
		if position.distance_to(drone.position) < 20:
			drone.explode_animation()
	queue_free()
	
func chain_reaction():
	for drone in get_tree().get_nodes_in_group('Drones'):
		if position.distance_to(drone.position) < 20:
			drone.explode_animation()
