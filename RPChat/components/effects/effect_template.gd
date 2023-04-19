class_name Effect
# Base class for all the effects types to inherit.
# Can be further specialized based on the effect's intended purpose
# (text/message/client)

var run_once = true  # If set to true, the effect will be removed when it will finish
var finished = false  # Whether the effect has finished the execution
var description = ''
var current_settings = {}  # will contain the effect instance settings from default+preset/keywords
var default_settings = {}
# Should be structured as:
# default_settings = {
# 	configurable_value: {
# 		'value': some_value,
#		'help': 'Explanation what does the parameter affect'
# 	}
# }
var presets = {}
# Should be structured as:
#presets = {
#	'some_preset': {
#		'config': {
#			<params that will be used to overwrite default settings>
#		},
#		'description': 'short preset description'
#	}
#}

func apply(_delta: float) -> void:
	# this method should execute character logic, may be ran more than once in loop
	# if the effect has finished executing and does not require to be ran again
	# then it should set the self.finished = true
	pass


func has_finished() -> bool:
	return self.finished


func get_param_help(key: String) -> String:
	if key in default_settings:
		return default_settings[key]['help']
	return ''


func get_param_list() -> Array[String]:
	return self.default_settings.keys()


func get_preset_description(preset: String) -> String:
	if preset in presets:
		return presets[preset]['description']
	return  ''


func get_preset_list() -> Array[String]:
	return self.presets.keys()


func get_description() -> String:
	return self.description
