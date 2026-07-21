extends CanvasLayer
class_name LoadingScreen


signal loading_screen_ready
#var rect_material: Material
@export var color_rect: ColorRect

var tween: Tween

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	color_rect.offset_transform_position_ratio.y = -1.0
	await transition_out()
	loading_screen_ready.emit()

func _on_progress_changed(_value: float) -> void:
	pass

func _on_load_finished() -> void:
	await transition_in()
	queue_free()

func transition_out(duration: float = 1.0) -> void:
	if color_rect.offset_transform_position_ratio.y != -1.0:
		color_rect.offset_transform_position_ratio.y = -1.0
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(color_rect, "offset_transform_position_ratio:y", 0.0, duration)
	await tween.finished

func transition_in(duration: float = 1.0) -> void:
	if color_rect.offset_transform_position_ratio.y != 0.0:
		color_rect.offset_transform_position_ratio.y = 0.0
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(color_rect, "offset_transform_position_ratio:y", 1.0, duration)
	await tween.finished
