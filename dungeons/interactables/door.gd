extends StaticBody2D


@export var interactable: Interactable
@export var sprite: Sprite2D
@export var collider: CollisionShape2D
@export var is_last_door: bool = true

const CLOSED_DOOR_REGION: Rect2 = Rect2(80.0, 368.0, 32.0, 16.0)
const OPEN_DOOR_REGION: Rect2 = Rect2(0.0, 427.0, 32.0, 21.0)

func _ready() -> void:
	sprite.region_rect = CLOSED_DOOR_REGION
	interactable.interact = _on_interact


func _on_interact() -> void:
	sprite.region_rect = OPEN_DOOR_REGION
	if is_last_door:
		SceneManager.reload_current_scene()
		#SceneManager.transition_to(SceneManager.SCENES.DungeonTutorial)
