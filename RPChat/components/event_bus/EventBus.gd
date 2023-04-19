extends Node
# Used as internal API for signals, all the signals used by effects, windows etc.
# should be defined here and every object interested in them can connect to them
# on their own

signal message_paused  # Emitted by Message when it paused
signal message_resumed # Emitted by Message when it gets resumed
signal message_finished_playing  # Emitted by Message when it finishes playing

signal client_effect_added(effect: C_Effect)  # Emitted by Message when new client effect is to be added
signal client_received_input  # Emitted by MainWindow when user interacts with it (keypress/mouse bytton)
signal client_added_message  # Emitted by MainWindow after Message is added
