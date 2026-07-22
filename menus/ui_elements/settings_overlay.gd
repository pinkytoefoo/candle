extends PanelContainer
class_name SettingsOverlay

@export var master_slider: HSlider
@export var music_slider: HSlider
@export var sounds_slider: HSlider
@export var back_button: Button

var master_bus_idx: int = AudioServer.get_bus_index(&"Master")
var music_bus_idx: int = AudioServer.get_bus_index(&"Music")
var sounds_bus_idx: int = AudioServer.get_bus_index(&"Sounds")

func _ready() -> void:
	#hide()
	master_slider.value_changed.connect(_master_slider_value_changed)
	music_slider.value_changed.connect(_music_slider_value_changed)
	sounds_slider.value_changed.connect(_sounds_slider_value_changed)
	back_button.pressed.connect(_back_button_pressed)
	
	master_slider.value = AudioServer.get_bus_volume_linear(master_bus_idx)
	music_slider.value = AudioServer.get_bus_volume_linear(music_bus_idx)
	sounds_slider.value = AudioServer.get_bus_volume_linear(sounds_bus_idx)

func toggle_options_menu() -> void:
	self.visible = !self.visible

func _master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(value))
	AudioServer.set_bus_mute(master_bus_idx, value <= 0.05)

func _music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_idx, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus_idx, value <= 0.05)

func _sounds_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sounds_bus_idx, linear_to_db(value))
	AudioServer.set_bus_mute(sounds_bus_idx, value <= 0.05)

func _back_button_pressed() -> void:
	hide()
