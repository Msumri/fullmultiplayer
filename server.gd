extends Node
class_name server_connect


func start_server():
	var peer =ENetMultiplayerPeer.new()
	peer.create_server(4221)
	multiplayer.multiplayer_peer=peer

func start_client(ip:String="localhost"):
	var peer =ENetMultiplayerPeer.new()
	peer.create_client(ip,4221 )
	multiplayer.multiplayer_peer=peer
