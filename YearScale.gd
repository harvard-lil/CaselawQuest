extends Node2D

var years : Array
var events : Dictionary
var cases : Dictionary

const case_scene : PackedScene = preload("res://Case.tscn")
const event_scene : PackedScene = preload("res://Event.tscn")

onready var tile_map : TileMap = get_node("../TileMap")

const YEAR_ELEMENT_WIDTH : int = 256
const OFFSET_INCREMENT : int = YEAR_ELEMENT_WIDTH / 5

func commit_scale():
	var populated_years : Array = cases.keys() + events.keys()
	populated_years.sort()
	var first_year : int = int(populated_years[0])
	var last_year : int = int(populated_years[-1])
	print(first_year, last_year)
	for year_index in range(populated_years.size()):
		if year_index + 1 == populated_years.size():
			break
		for fill_in_year in range(int(populated_years[year_index]), int(populated_years[year_index + 1])):
			years.append(fill_in_year)
	
	for year_index in range(years.size() + 1):

		var year_int : int = year_index + int(years[0])
		var year_key : String = str(year_int)
		
		var thisLabel = Label.new()
		var base_x : int = year_index * YEAR_ELEMENT_WIDTH
		thisLabel.set_text(year_key)
		thisLabel.set_position(Vector2(base_x - 32, 0))
		thisLabel.add_font_override("font", load("res://DialogDynamicFontName.tres"))
		self.add_child(thisLabel)
		
		tile_map.set_cell(year_index, 0, 0)

		if year_key in cases:
			var offset : int = 0
			for case in cases[year_key]:
				var create_case = case_scene.instance()
				self.add_child(create_case)
				create_case.set_name(case.name)
				create_case.set_date(case.decision_date)
				create_case.set_url(case.url)
				create_case.set_reporter(case.reporter)
				create_case.set_jurisdiction(case.jurisdiction)
				create_case.set_citation(case.citation)
				create_case.set_court(case.court)
				create_case.set_position(Vector2(base_x + offset, -265))
				create_case.set_short_desc(case.short_description)
				create_case.set_long_desc(case.long_description)
				create_case.set_offset(offset)
				offset += OFFSET_INCREMENT
				if 'color' in case and case.color != '':
					create_case.set_color(case.color)
				else:
					create_case.set_color("#000000")
		
		if year_key in events:	
			var offset : int = 0
			for event in events[year_key]:
				var create_event = event_scene.instance()
				self.add_child(create_event)
				create_event.set_name(event.name)
				create_event.set_date(event.start_date, event.end_date)
				create_event.set_url(event.url)
				create_event.set_position(Vector2(base_x, -225))
				create_event.set_short_desc(event.short_description)
				create_event.set_long_desc(event.long_description)
				create_event.set_offset(offset)
				offset += OFFSET_INCREMENT
				if 'color' in event and event.color != '':
					create_event.set_color(event.color)
				else:
					create_event.set_color("#000000")
	
	tile_map.set_cell((years.size()) + 1, 0, 0)
	tile_map.set_cell((years.size()) + 2, 0, 1)

func add_event(evt):
	var start_year : String = evt.get('start_date').split('-', true, 1)[0]
	var end_year : String = evt.get('end_date').split('-', true, 1)[0]
	for year_int in range(int(start_year), int(end_year) + 1):
		var year_key : String = str(year_int)
		if not year_key in events:
			events[year_key] = Array()
	events[start_year].append(evt)
	
func add_case(cas):
	var decision_year : String = cas.get('decision_date').split('-', true, 1)[0]
	if not decision_year in cases:
		cases[decision_year] = Array()
	cases[decision_year].append(cas)
