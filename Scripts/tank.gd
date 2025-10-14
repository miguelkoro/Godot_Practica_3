extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var canon: Sprite2D = $canon

@export var gravity = 220
@export var speed = 100
@export var jump_force = 175
@export var canon_force = 1

const AMMUNITION = preload("uid://bnxjtrxm7hmbp")


func  _physics_process(delta: float) -> void:
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else: 
		velocity.y = max(velocity.y,0)
		
	#Horizontal movement
	var input_dir := 0
	if(Input.is_action_pressed("ui_left")):
		input_dir-= 1
		animated_sprite_2d.play("moving")
	elif(Input.is_action_pressed("ui_right")):
		input_dir+= 1
		animated_sprite_2d.play("moving")
	else:
		animated_sprite_2d.play("idle")
	velocity.x = input_dir * speed
	
	#Jump
	if(Input.is_action_just_pressed("ui_jump") and is_on_floor()):
		velocity.y = -jump_force 
		animated_sprite_2d.play("idle")
		
	#Apply movement with colision
	move_and_slide()

func _input(event: InputEvent) -> void:
	#Storing mouse position
	if event is InputEventMouseMotion:
		canon.rotation = global_position.angle_to_point(viewport_pos_to_world(event.position))-PI
	
	#Left mouse click button
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#Instanciar la bola de cañon
		var ammunition = AMMUNITION.instantiate()
		#ammunition.global_position = (event.position)-global_position.normalized()
		
		ammunition.apply_central_impulse(viewport_pos_to_world((event.position)-global_position.normalized())*canon_force)
		
		print("fdfds")
		add_child(ammunition)
		
func viewport_pos_to_world(event_pos: Vector2) -> Vector2:
	return get_viewport().get_canvas_transform().affine_inverse() * event_pos
	
