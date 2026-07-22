extends StaticBody2D
class_name Cobweb

@export var interactable: Interactable

func _ready() -> void:
	interactable.interact = set_on_fire

func set_on_fire() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 0.8, 0.0, 1), 0.1)
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.1)
	tween.tween_callback(func() -> void:
		queue_free()
		
		# HACK: using interactable area to check for other cobwebs
		# TODO: find a better way of setting other neighboring cobwebs on fire
		for area in interactable.get_overlapping_areas():
			var parent = area.get_parent()
			if parent is Cobweb:
				if parent.has_method("set_on_fire"):
					parent.set_on_fire()
	)
