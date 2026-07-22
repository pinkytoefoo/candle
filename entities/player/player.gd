extends CharacterBody2D
class_name Player

#region exports
@export_group("Nodes")
@export var animated_sprite: AnimatedSprite2D
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
	
	_handle_animations()
	
	wax -= delta*heat_scale
	velocity = input_dir.normalized() * speed+knockback
	
	move_and_slide()
	knockback=lerp(knockback,Vector2.ZERO, 0.1)
	if wax<=0.0:
		SceneManager.reload_current_scene()

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
	candle.scale=Vector2.ONE*heat_scale
	
func take_damage(enemypos)->void:
	wax-=10
	knockback=(enemypos.direction_to(global_position))*100
	
