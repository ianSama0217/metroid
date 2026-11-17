extends Node2D

var direction: Vector2

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2.ONE, 0.3).from(Vector2.ZERO)

func setup(pos: Vector2, dir: Vector2):
	position = pos + dir * 16
	direction = dir

func _physics_process(delta: float) -> void:
	position += direction * 300 * delta


func _on_area_2d_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()
