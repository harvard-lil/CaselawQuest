extends CheckButton

var position : float = 0.0
onready var player : AudioStreamPlayer = get_parent()
	
func _ready():
	set_as_toplevel(true)
	
func _on_Music_Mute_toggled(_button_pressed):
	if player.playing:
		position = player.get_playback_position()
		player.stop()
	else:
		player.play(position)
