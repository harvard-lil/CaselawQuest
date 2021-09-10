extends Node2D

var years : Array
var events : Dictionary
var cases : Dictionary

const YEAR_ELEMENT_WIDTH : int = 256
const case_scene : PackedScene = preload("res://Case.tscn")
const event_scene : PackedScene = preload("res://Event.tscn")
const year_label : PackedScene = preload("res://YearLabel.tscn")

onready var tile_map : TileMap = get_node("../TileMap")

func commit_scale():
	var populated_years : Array = cases.keys() + events.keys()
	populated_years.sort()
	var first_year : int = int(populated_years[0])
	var last_year : int = int(populated_years[-1])
	for year_index in range(populated_years.size()):
		if year_index + 1 == populated_years.size():
			break
		for fill_in_year in range(int(populated_years[year_index]), int(populated_years[year_index + 1])):
			years.append(fill_in_year)
	
	for year_index in range(years.size() + 1):
		
		var year_int : int = year_index + int(years[0])
		var year_key : String = str(year_int)
		var new_year_label = year_label.instance()
		new_year_label.set_text(year_key)
		new_year_label.set_year_element_width(YEAR_ELEMENT_WIDTH)
		new_year_label.set_year_index(year_index)
		self.add_child(new_year_label)
		
		tile_map.set_cell(year_index, 0, 0)

		if year_key in cases:
			for i in cases[year_key].size():
				var case = cases[year_key][i]
				var create_case = case_scene.instance()
				create_case.set_year_element_width(YEAR_ELEMENT_WIDTH)
				create_case.year_index = year_index
				create_case.title = case.name
				create_case.url = case.url

				create_case.reporter = case.reporter
				create_case.jurisdiction = case.jurisdiction
				create_case.citation = case.citation
				create_case.court = case.court
				create_case.short_desc = case.short_description
				create_case.long_desc = case.long_description
				create_case.offset = i
				create_case.set_date(case.decision_date)
				if 'color' in case and case.color != '':
					create_case.set_color(case.color)
				else:
					create_case.set_color("#000000")
				self.add_child(create_case)
		
		if year_key in events:	
			for event in events[year_key]:
				var start_year : int = int((event.get('start_date').split('-', true, 1)[0]))
				var end_year : int = int((event.get('end_date').split('-', true, 1)[0]))
				var create_event = event_scene.instance()
				create_event.year_index = year_index
				create_event.title = event.name
				create_event.url = event.url
				create_event.start_year = start_year
				create_event.end_year = end_year
				create_event.short_desc = event.short_description
				create_event.long_desc = event.long_description
				create_event.offset = event.offset_level
				create_event.set_year_element_width(YEAR_ELEMENT_WIDTH)
				create_event.set_date(event.start_date, event.end_date)
				self.add_child(create_event)
				if 'color' in event and event.color != '':
					create_event.set_color(event.color)
				else:
					create_event.set_color("#000000")
	
	tile_map.set_cell((years.size()) + 1, 0, 0)
	tile_map.set_cell((years.size()) + 2, 0, 1)

func add_event(evt):
	var start_year : String = evt.get('start_date').split('-', true, 1)[0]
	var end_year : String = evt.get('end_date').split('-', true, 1)[0]
	evt['offset_level'] = 0
	for year_int in range(int(start_year), int(end_year) + 1):
		var year_key : String = str(year_int)
		if not year_key in events:
			events[year_key] = Array()
		else:
			if events[year_key].size() > evt['offset_level']:
				evt['offset_level'] = events[year_key].size() 
	events[start_year].append(evt)
	
func add_case(cas):
	var decision_year : String = cas.get('decision_date').split('-', true, 1)[0]
	if not decision_year in cases:
		cases[decision_year] = Array()
	cases[decision_year].append(cas)

