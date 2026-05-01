extends Area2D
@onready var healthbar: ProgressBar = $healthbar

var health:float=100.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	healthbar.max_value=health
	healthbar.value=health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(amount:float):
	health-=amount
	healthbar.value=health
	if health<=0:
		print("game over")

@rpc("any_peer","reliable","call_local")
func set_health(current_health):
	health=current_health
	healthbar.value=health
