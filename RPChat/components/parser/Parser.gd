extends Node

var _message_regex = RegEx
var _tag_regex = RegEx
var _kwd_regex = RegEx



func _ready():
	_message_regex = RegEx.new()
	_tag_regex = RegEx.new()
	_kwd_regex = RegEx.new()
	
	_message_regex.compile('(?<text>(.|\n)*?)({{(?<tag>.*?)}}|\\z)')
	_tag_regex.compile('((?<key>\\S+)\\s*:\\s*(?<kwd>.+?)\\s*(;|$))|(?<command>\\S+)\\s*(;|$)')
	_kwd_regex.compile('(?<kwd>\\S+)\\s*=\\s*(?<kwv>\\S+)|(?<macro>\\S+)')
	
	set_process(false)


func parse_message(text):
	# will return array of text/commands (dicts)
	var results = []
	for token in _message_regex.search_all(text):
		var text_content = token.get_string('text')
		var tag_content = token.get_string('tag')
		
		if text_content:
			results.append(text_content)
		if tag_content:
			results.append(parse_tag(tag_content))
	
	return results


func parse_tag(text):
	# parses the contents of {{ }} tag
	var tag = {}
	for token in _tag_regex.search_all(text):
		var key = token.get_string('key')
		var command = token.get_string('command')
		if key:
			tag[key] = parse_kwd(token.get_string('kwd'))
		if command:
			# TODO maybe instead add all effects as elements of array under key 'effects'
			tag[command] = {'macros': []}
	
	return tag


func parse_kwd(text):
	# parses the keyword parameters in tag after ":"
	var settings = {'macros': []}
	for token in _kwd_regex.search_all(text):
		var kwd = token.get_string('kwd')
		var macro = token.get_string('macro')
		if kwd:
			settings[kwd] = token.get_string('kwd')
		if macro:
			settings['macros'].append(macro)
	
	return settings
