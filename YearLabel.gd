extends Label

var year_element_width : int
var year_index : int = 0

func _ready():
	self.set_position(Vector2((year_element_width * year_index) - 32, 0))

func set_year_element_width(wdth):
	year_element_width = wdth
	
func set_year_index(idx):
	year_index = idx
