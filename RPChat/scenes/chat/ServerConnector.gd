extends HTTPRequest

signal incoming_data(data)

# The URL we will connect to
var is_connected = false
@export var websocket_url = "ws://192.168.1.67:8000/echo"

# Our WebSocketClient instance
var _client = WebSocketClient.new()

func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", Callable(self, "_closed"))
	_client.connect("connection_error", Callable(self, "_closed"))
	_client.connect("connection_established", Callable(self, "_connected"))
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", Callable(self, "_on_data"))

	print("starting connection")
	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _closed(was_clean = false):
	self.is_connected = false
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print(websocket_url, " Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	self.is_connected = true
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	_client.get_peer(1).put_packet("Test packet".to_utf8_buffer())

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var data = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Got data from server: ", data)
	emit_signal("incoming_data", data)

func send_data(data: String):
	if self.is_connected:
		_client.get_peer(1).put_packet(data.to_utf8_buffer())

func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()
