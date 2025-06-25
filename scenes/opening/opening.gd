extends Control

@export var next_scene:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimationPlayer.play("opening")
	if not $AnimationPlayer.is_playing():
		get_tree().change_scene_to_file(next_scene)
	pass
