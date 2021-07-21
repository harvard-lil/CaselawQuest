extends Area2D

onready var sprite : AnimatedSprite = get_node("AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	var _trash = connect("body_entered", self, "handle_area_entered")
	_trash = connect("body_exited", self, "handle_area_exited")
	
func handle_area_entered(player):
	player.register_proximity(get_parent())
	
func handle_area_exited(player):
	player.unregister_proximity(get_parent())
