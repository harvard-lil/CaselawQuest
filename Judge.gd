extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const movement_pattern : Array = [ 0, 0.5, 1, 1.5, 2, 3, 4, 3, 2, 1.5, 1, 0.5 ]
var time_passed : float = 0.0
var movement_index = 0
onready var sprite : AnimatedSprite = get_node("AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_judge : String = str(rng.randi_range(1, 35))
	sprite.play(random_judge)
# warning-ignore:return_value_discarded
	var _trash = connect("body_entered", self, "handle_area_entered")
	_trash = connect("body_exited", self, "handle_area_exited")
	
func handle_area_entered(player):
	player.register_proximity(get_parent())
	
func handle_area_exited(player):
	player.unregister_proximity(get_parent())

func _process(delta):
	time_passed += delta
	if time_passed > 0.3:
		time_passed = 0.0
		if movement_index >= movement_pattern.size():
			movement_index = 0
		sprite.position.y = movement_pattern[movement_index] * -1
		movement_index += 1
