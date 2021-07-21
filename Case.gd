extends "res://TimelineElement.gd"

var court : String
var citation : String
var reporter : String
var jurisdiction : String

func _ready():
	 a2d = get_node("Judge")

func push_to_dialog():
	.push_to_dialog()
	dialog.set_field(2, "Court", court)
	dialog.set_field(5, "Citation", citation)
	dialog.set_field(4, "Reporter", reporter)
	dialog.set_field(0, "Jurisdiction", jurisdiction)
	
func set_court(data):
	court = data
	
func set_citation(data):
	citation = data

func set_reporter(data):
	reporter = data

func set_jurisdiction(data):
	jurisdiction = data
	
func handleClick():
	.handleClick()
