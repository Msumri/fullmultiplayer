extends MultiplayerSpawner

@export var netwok_player:PackedScene
@onready var camera_2d: Camera2D = $"../Camera2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(spawn_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_player(id:int)->void:
	if !multiplayer.is_server(): return
	
	var player:Player=netwok_player.instantiate()
	
	player.name=str(id)
	
	get_node(spawn_path).add_child(player)
	


func _on_spawned(node: Node) -> void:
	if node.is_multiplayer_authority():
		camera_2d.target=node
