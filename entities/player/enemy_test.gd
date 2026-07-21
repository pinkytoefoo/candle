extends CharacterBody2D

@onready var target = $"../Player"

var speed = 10
var distance
var direction
var radius

func _physics_process(delta: float) -> void:
	radius = 24.0 * target.heat_scale
	distance = global_position.distance_to(target.global_position)
	direction = (target.global_position - global_position).normalized()

	if distance > radius+4:
		velocity = direction * speed
	elif distance < radius-4:
		velocity = -direction * (speed * 0.7)
	else:
		velocity=Vector2.ZERO

	move_and_slide()
	for i in get_slide_collision_count():
		var obj=get_slide_collision(i).get_collider()
		if obj is Player:
			target.take_damage(global_position)
			
