extends CanvasLayer

@onready var server: Button = $server
@onready var client: Button = $client


func _on_server_pressed() -> void:
	Server.start_server()
	server.disabled=true
	client.disabled=true
func _on_client_pressed() -> void:
	Server.start_client()
	server.disabled=true
	client.disabled=true
