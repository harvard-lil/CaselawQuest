extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2.0), "timeout")
	get_node("topText").show()
	yield(get_tree().create_timer(4.0), "timeout")
	get_node("bottomText").show()
	yield(get_tree().create_timer(6.0), "timeout")
	self.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
