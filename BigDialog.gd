extends Control

var url : String

onready var short_desc = get_node("NinePatchRect2/ShortDesc")
onready var long_desc = get_node("NinePatchRect2/LongDesc")
onready var dialog_name = get_node("NinePatchRect2/Name")

onready var fields : Array = [ 
	get_node("NinePatchRect2/Field 0"),
	get_node("NinePatchRect2/Field 1"),
	get_node("NinePatchRect2/Field 2"),
	get_node("NinePatchRect2/Field 3"),
	get_node("NinePatchRect2/Field 4"),
	get_node("NinePatchRect2/Field 5"),
	get_node("NinePatchRect2/Field 6"),
	get_node("NinePatchRect2/Field 7"),
]

func set_name(value):
	dialog_name.get_node("ScrollContainer/Text").set_text(value)
	
func set_short_desc(value):
	short_desc.get_node("ScrollContainer/Text").set_text(value)

func set_long_desc(value):
	long_desc.get_node("ScrollContainer/Text").set_text(value)

func set_url(value):
	url = value

func set_field(field_number, label, value):
	fields[field_number].get_node("Label").set_text(label)
	fields[field_number].get_node("Value").set_text(value)

func handleClick():
	var _throwaway = OS.shell_open(url)
