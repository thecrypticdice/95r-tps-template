extends PanelContainer

@onready var input_button = preload("res://scenes/menus/options_menu/input/input_button.tscn")
@onready var action_list = $"MarginContainer/ScrollContainer/action list"
var is_remaping:bool = false
var action_to_remap = null
var remaping_button = null
var input_actions = [
	"action_a","action_b",
	"action_c","action_d",
	"action_e"
	]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	InputMap.load_from_project_settings()
	for i in action_list.get_children():
		i.queue_free()
		input_actions = InputMap.get_actions()
	for action in input_actions:
		var button = input_button.instantiate()
		button.find_child("action").text = action.replace("_", " ")
		var events = InputMap.action_get_events(action)
		if events.size() >0:
			button.find_child("input").text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			button.find_child("input").text = "nothing"
		action_list.add_child(button)
		button.pressed.connect(on_button_pressed.bind(button,action))
	pass # Replace with function body.

func on_button_pressed(button,action):
	if ! is_remaping:
		is_remaping = true
		action_to_remap = action
		remaping_button = button
		button.find_child("input").text = "presss key to bind"
	pass
func _input(event: InputEvent) -> void:
	if is_remaping:
		if event is InputEventKey or (event is InputEventMouseButton and event.pressed):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap,event)
			update_action_list(remaping_button,event)
			is_remaping = false
			remaping_button = null
			action_to_remap = null
			accept_event()
			pass
func update_action_list(button,event):
	button.find_child("input").text = event.as_text().trim_suffix(" (Physical)")
	
