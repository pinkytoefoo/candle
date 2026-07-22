extends HBoxContainer
class_name AudioSlider

@export var label: Label
@export var slider: HSlider
@export var bus_name: StringName

var _bus_index: int

func _ready() -> void:
	_bus_index = AudioServer.get_bus_index(bus_name)
	slider.value = AudioServer.get_bus_volume_linear(_bus_index)
	slider.value_changed.connect(_update_slider)

func _update_slider(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus_index, linear_to_db(value))
	# a threshold because sliders are so huge on lower res viewports
	AudioServer.set_bus_mute(_bus_index, value <= 0.05)
	print(AudioServer.get_bus_volume_linear(_bus_index))
