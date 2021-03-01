extends VBoxContainer

var linecount = 0
var total_elements = 0
var elements_in_lines = [0]



func _ready() -> void:
	$CharacterContainer.set("custom_constants/separation", 0)


func append(element):
	get_child(linecount).add_child(element)
	elements_in_lines[linecount] += 1
	total_elements += 1


func newline():
	var new_hbox = HBoxContainer.new()
	new_hbox.set("custom_constants/separation", 0)
	add_child(new_hbox)
	linecount += 1
	elements_in_lines.append(0)


func get_element(idx: int):
	if idx < 0 or idx >= total_elements:
		pass  # TODO index out of range, handle it

	var start_idx = 0
	var line = 0
	
	while start_idx + elements_in_lines[line] - 1 < idx:  # FIXME will fail on empty lines
		start_idx += elements_in_lines[line]
		line += 1
	
	return get_child(line).get_child(idx - start_idx)
