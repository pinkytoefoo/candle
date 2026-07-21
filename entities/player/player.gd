extends CharacterBody2D
class_name Player

#region exports
@export_group("Nodes")
@export var animated_sprite: AnimatedSprite2D
@export var wax_bar: ProgressBar
@export_group("")

@export_group("Feel")
@export var speed: float = 100.0
@export_group("")
#endregion

#region state
var input_dir: Vector2 = Vector2.ZERO

var wax: float = 10.0:
	set(val):
		wax = val
		_update_wax_ui()
#endregion

func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	_handle_animations()
	
	wax -= delta
	velocity = input_dir.normalized() * speed
	move_and_slide()

func _handle_animations() -> void:
	if input_dir == Vector2.ZERO:
		animated_sprite.play(&"idle_front")
		return
	
	if abs(input_dir.x) > abs(input_dir.y) or abs(input_dir.x) == abs(input_dir.y):
		animated_sprite.flip_h = (input_dir.x < 0)
		animated_sprite.play(&"run_side")
	else:
		animated_sprite.flip_h = false
		if input_dir.y > 0:
			animated_sprite.play(&"run_front")
		else:
			animated_sprite.play(&"run_back")

func _update_wax_ui() -> void:
	wax_bar.value = wax
