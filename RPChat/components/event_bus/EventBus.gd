extends Node
# Used as internal API for signals, all the signals used by effects, windows etc.
# should be defined here and every object interested in them can connect to them
# on their own

signal message_finished_playing
signal message_added
signal pause_message
signal resume_message

signal client_effect_added(effect: C_Effect)
