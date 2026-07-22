extends PanelContainer

@export var back_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.pressed.connect(hide)
