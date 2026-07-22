extends CharacterBody2D
class_name Player

#region exports
@export_group("Nodes")
#@export var animated_sprite: AnimatedSprite2D
#@export var cha
@export var wax_bar: ProgressBar
@export var candle: Sprite2D
@export_group("")

@export_group("Feel")
@export var speed: float = 100.0
@export_group("")
#endregion

#region state
var input_dir: Vector2 = Vector2.ZERO
var heat_scale:float=.8 
var knockback=Vector2.ZERO

var rotate_time: float = 0.0

var wax: float = 10.0:
	set(val):
		wax = val
		_update_wax_ui()
#endregion

func _ready() -> void:
	wax_bar.max_value = wax

func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_released("scroll_up") and heat_scale<1.1:
		heat_scale+=.05
	if Input.is_action_just_released("scroll_down") and heat_scale>0.1:
		heat_scale-=.05
	
	_handle_animations(delta)
	
	wax -= delta*heat_scale
	velocity = input_dir.normalized() * speed+knockback
	
	move_and_slide()
	knockback=lerp(knockback,Vector2.ZERO, 0.1)
	if wax<=0.0:
		SceneManager.reload_current_scene()

func _handle_animations(delta) -> void:
	if input_dir != Vector2.ZERO:
		rotate_time = wrapf(rotate_time + (delta * 20.0), 0, 20.0 * 10)
		candle.rotation = sin(rotate_time) * deg_to_rad((-18.0) * sign(input_dir.x if input_dir.x != 0 else 1.0))
	else:
		rotate_time = 0.0
		candle.rotation = lerp(candle.rotation, 0.0, delta * 10)

func _update_wax_ui() -> void:
	wax_bar.value = wax
	candle.scale=Vector2.ONE*heat_scale
	
func take_damage(enemypos)->void:
	wax-=10
	knockback=(enemypos.direction_to(global_position))*100
