extends CharacterBody2D
class_name Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var crosshair: Sprite2D = %crosshair
@onready var healthcomp: Area2D = $healthcomp

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	set_multiplayer_authority(name.to_int())
	
func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority():
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity==Vector2.ZERO:
		show_animation("idle")
	else:
		show_animation("walk")
	
	if global_position.x<crosshair.global_position.x:
		animated_sprite_2d.flip_h=false
	else:
		animated_sprite_2d.flip_h=true
	
	if Input.is_action_just_pressed("fire"):
		req_fire.rpc_id(1,25)
	move_and_slide()

func show_animation(animation:String):
	animated_sprite_2d.play(animation)

@rpc("authority","reliable")
func req_fire(dmg:float):
	if !multiplayer.is_server(): return
	
	fire(dmg)
	
func fire(dmg:float):
	var players=get_tree().get_nodes_in_group("player")
	for player in players:
		player.healthcomp.take_damage(dmg)
		player.healthcomp.set_health.rpc(healthcomp.health)
