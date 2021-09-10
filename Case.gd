extends Node2D

var court : String
var citation : String
var reporter : String
var jurisdiction : String
var label_offset : int = -265

var offset_increment : Vector2

var title : String
var first_date : String
var second_date # : String -- apparently hinted variables aren't nullable
var date_string : String
var date_string_label : String = "Decision Date"
var short_desc : String
var long_desc : String
var url : String
var sprite_line_target_x : int
var sprite_line_target_y : int
var color : Color
var a2d : Area2D
var offset : int
var year_index : int
var year_element_width : int


const BASE_OFFSET : int = -258

onready var name_label : LinkButton = get_node("NameLink")
onready var date_label : Label = get_node("DateLabel")
onready var dialog : Control = get_node("/root/MainScene/UIController/Dialog")
onready var player : KinematicBody2D = get_node("../../MainPlayer")
onready var name_initial_x : int = name_label.rect_position.x
onready var name_initial_y : int = name_label.rect_position.y
onready var date_initial_x : int = date_label.rect_position.x
onready var date_initial_y : int = date_label.rect_position.y


func _ready():
	a2d = get_node("Judge")
	name_label.set_text(title)
	date_label.set_text(date_string)
	self.set_position(Vector2((year_start_x() + (offset * offset_increment.x)), BASE_OFFSET))
	
func push_to_dialog():
	dialog.set_name(title)
	dialog.set_field(1, date_string_label, date_string)
	dialog.set_short_desc(short_desc)
	dialog.set_long_desc(long_desc)
	dialog.set_url(url)
	dialog.set_field(2, "Court", court)
	dialog.set_field(5, "Citation", citation)
	dialog.set_field(4, "Reporter", reporter)
	dialog.set_field(0, "Jurisdiction", jurisdiction)

func set_year_element_width(wdth):
	year_element_width = wdth
	offset_increment = Vector2(year_element_width / 5, 32)

func year_start_x():
	return year_index * year_element_width
	
func set_date(incoming_first_date, incoming_second_date=null):
	first_date = incoming_first_date
	second_date = incoming_second_date
	if not second_date:
		date_string = first_date
	else:
		if first_date == second_date:
			date_string_label = "Happened On"
			date_string = "%s" % first_date
		else:
			date_string_label = "Date Range"
			date_string = "%s to %s" % [first_date, second_date]

#func set_categories(data):
#	dialog.set_field(0, "Categories", data)
#	url = data

func set_color(new_color):
	color = Color(new_color)

func showDialog():
	push_to_dialog()
	dialog.show()

func hideDialog():
	dialog.hide()
	
func x_offset():
	return year_start_x() + (offset * offset_increment.x)
	
func label_offset():
	return (offset_increment.y * offset) * -1

func handleClick():
	var _throwaway = OS.shell_open(url)
	dialog.set_field(2, "Court", court)
	dialog.set_field(5, "Citation", citation)
	dialog.set_field(4, "Reporter", reporter)
	dialog.set_field(0, "Jurisdiction", jurisdiction)

func _process(_delta):
	if label_offset() != name_label.rect_position.y:
		name_label.rect_position.y = name_initial_y + label_offset()
		date_label.rect_position.y = date_initial_y + label_offset()
		update()

func _draw():
	var x_from : int = (date_label.rect_position.x + date_label.rect_size.x / 2)
	var y_from : int = (date_label.rect_position.y + date_label.rect_size.y)
	draw_line(
		Vector2(x_from, y_from), 
		Vector2(a2d.position.x , a2d.position.y ), 
		color)
