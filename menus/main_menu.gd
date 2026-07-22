extends Control


@export var play_button: Button
@export var settings_button: Button
@export var credits_button: Button
@export var quit_button: Button
@export var settings_overlay: PanelContainer
@export var credits_overlay: PanelContainer
@export var light: Node2D

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(get_tree().quit)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		light.global_position = get_global_mouse_position()

func _on_play_pressed() -> void:
	SceneManager.transition_to(SceneManager.SCENES.DungeonTutorial)

func _on_settings_pressed() -> void:
	settings_overlay.visible = !settings_overlay.visible

func _on_credits_pressed() -> void:
	credits_overlay.visible = !credits_overlay.visible
