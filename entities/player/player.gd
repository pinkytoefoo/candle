extends CharacterBody2D
class_name Player


@export_group("Nodes")
@export var animated_sprite: AnimatedSprite2D
@export var candle: Sprite2D
@export_group("")

@export_group("Feel")
@export var speed: float = 100.0
@export_group("")

var input_dir: Vector2 = Vector2.ZERO
var heat_scale:float=.8 
var knockback=Vector2.ZERO

var wax: float = 100.0

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_released("scroll_up") and heat_scale<1.1:
		heat_scale+=.05
	if Input.is_action_just_released("scroll_down") and heat_scale>0.1:
		heat_scale-=.05
	
	_handle_animations()
	
	wax -= delta*heat_scale
	
	velocity = input_dir * speed+knockback
	move_and_slide()
	knockback=lerp(knockback,Vector2.ZERO, 0.1)
	print(wax)

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
	candle.scale=Vector2.ONE*heat_scale
	
func take_damage(enemypos)->void:
	wax-=10
	knockback=(enemypos.direction_to(global_position))*100
	
