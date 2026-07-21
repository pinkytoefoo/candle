extends CharacterBody2D
class_name Player


@export_group("Feel")
@export var speed: float = 500.0
@export_group("")

var input_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	velocity = input_dir * speed
	move_and_slide()
