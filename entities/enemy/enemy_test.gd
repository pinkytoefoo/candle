extends CharacterBody2D

@onready var target =$"../Player"

var speed = 15
var distance
var direction
var radius
func _ready():
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	radius = 35.0 * target.heat_scale
	distance = global_position.distance_to(target.global_position)
	direction = (target.global_position - global_position).normalized()

	if distance > radius+4:
		velocity = direction * speed
	elif distance < radius-4:
		velocity = -direction * (speed * 0.7)
	else:
		velocity=Vector2.ZERO

	move_and_slide()
