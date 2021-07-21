extends Control

var jPath : String 
var jString : File = File.new()
var jData : JSONParseResult

onready var year_scale : Node2D = get_node("/root/MainScene/YearScale")
onready var main_scene : Node2D = get_node("/root/MainScene/")
onready var author_label : Label = get_node("/root/MainScene/UIController/Author Label")
onready var title_label : Label = get_node("/root/MainScene/UIController/Title Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	var _discard = get_tree().connect("files_dropped", self, "_handleDrop")

func _handleDrop(files : PoolStringArray, _screen : int) -> void:
	jPath = files[0] # this handles multiple files— just get the first one
	# TODO figure out how to deal with bad files gracefully
	
	var _do_something_with_this = jString.open(jPath, File.READ)
	jData = JSON.parse(jString.get_as_text())
	
	if jData.error == OK and typeof(jData.result) == TYPE_DICTIONARY:  # If parse OK
		var timeline : Dictionary = jData.result
		get_parent().set_author(timeline.author)
		get_parent().set_title(timeline.title)
		for event in timeline.get('events'):
			year_scale.add_event(event)
		for case in timeline.get('cases'):
			year_scale.add_case(case)
		year_scale.commit_scale()
		get_parent().start_game()
	else:  # If parse has errors
		print("Error: ", jData.error)
		print("Error Line: ", jData.error_line)
		print("Error String: ", jData.error_string)
	self.queue_free()
	
