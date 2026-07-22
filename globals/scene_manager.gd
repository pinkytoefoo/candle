extends Node

# mostly queble tutorial with https://www.youtube.com/watch?v=m4PfHg3hmSo&vl=en

signal progress_changed(delta: float)
signal load_finished


# getting scenes via uid
const SCENES = {
	&"LoadingScreen": "uid://b1yfl3aa31uab",
	&"DungeonTutorial": "uid://cppa3jnqfrxmj",
	&"Player": "res://entities/player/player.tscn",
}

var loading_screen: PackedScene = preload(SCENES.LoadingScreen)
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []
var use_subthreads: bool = true

var config: Resource = null

var current_loading_screen: LoadingScreen

func _ready() -> void:
	set_process(false)

func transition_to(scene_: String, config_: Resource = null) -> void:
	scene_path = scene_
	config = config_
	
	current_loading_screen = loading_screen.instantiate()
	add_child(current_loading_screen)
	print(current_loading_screen)
	#progress_changed.connect(current_loading_screen._on_progress_changed, CONNECT_ONE_SHOT)
	load_finished.connect(current_loading_screen._on_load_finished, CONNECT_ONE_SHOT)
	
	await current_loading_screen.loading_screen_ready
	
	_start_load()

func reload_current_scene() -> void:
	current_loading_screen = loading_screen.instantiate()
	add_child(current_loading_screen)
	load_finished.connect(current_loading_screen._on_load_finished, CONNECT_ONE_SHOT)
	await current_loading_screen.loading_screen_ready
	get_tree().reload_current_scene()
	load_finished.emit()

func _start_load() -> void:
	var state: Error = ResourceLoader.load_threaded_request(scene_path, "", use_subthreads)
	if state == OK:
		set_process(true)

func _process(_delta: float) -> void:
	var load_status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# NOTE: could be used for progress bar
			# not enough time for jam though
			#progress_changed.emit(progress[0])
			#var percentage = progress[0] * 100
			pass
	
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			load_finished.emit()
			get_tree().paused = true
			get_tree().change_scene_to_packed(loaded_resource)
			await current_loading_screen.tween.finished
			get_tree().paused = false
			set_process(false)
	
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
