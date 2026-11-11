extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal shoot(pos: Vector2, dir: Vector2)

const gun_dir = {
	Vector2i(1, 0): 0, 
	Vector2i(1, 1): 1, 
	Vector2i(0, 1): 2, 
	Vector2i(-1, 1): 3, 
	Vector2i(-1, 0): 4, 
	Vector2i(-1, -1): 5, 
	Vector2i(0, -1): 6,
	Vector2i(1, -1): 7 
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Hamdle shoot
	if Input.is_action_just_pressed("shoot") and $ReloadTimer.time_left == 0:
		shoot.emit(position, get_local_mouse_position().normalized())
		$ReloadTimer.start()
		
		var tween = get_tree().create_tween()
		tween.tween_property($Marker, "scale", Vector2(0.1, 0.1), 0.2)
		tween.tween_property($Marker, "scale", Vector2(0.5, 0.5), 0.4)

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	animation()
	update_marker()
	move_and_slide()
	
func animation():
	$Legs.flip_h = velocity.x < 0
	if not is_on_floor():
		$AnimationPlayer.current_animation = 'jump'
	else:
		$AnimationPlayer.current_animation = 'run' if velocity.x else 'idle'
		
	var raw_dir = get_local_mouse_position().normalized()
	var adjusted_dir = Vector2i(round(raw_dir.x), round(raw_dir.y))
	#print(adjusted_dir)
	$Toros.frame = gun_dir[adjusted_dir]

func update_marker():
	$Marker.position = get_local_mouse_position().normalized() * 50
