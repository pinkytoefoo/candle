extends CharacterBody2D
class_name Player


@export_group("Nodes")
@export var animated_sprite: AnimatedSprite2D
@export_group("")

@export_group("Feel")
@export var speed: float = 100.0
@export_group("")

var input_dir: Vector2 = Vector2.ZERO

var wax: float = 100.0

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	_handle_animations()
	
	wax -= delta
	
	velocity = input_dir * speed
	move_and_slide()

func _handle_animations() -> void:
	match input_dir:
		Vector2(1.0, 0.0):
			animated_sprite.flip_h = false
			animated_sprite.play(&"run_side")
		Vector2(-1.0, 0.0):
			animated_sprite.flip_h = true
			animated_sprite.play(&"run_side")
		Vector2(0.0, 1.0):
			animated_sprite.play(&"run_front")
		Vector2(0.0, -1.0):
			animated_sprite.play(&"run_back")
		Vector2(0.0, 0.0):
			animated_sprite.play(&"idle_front")
