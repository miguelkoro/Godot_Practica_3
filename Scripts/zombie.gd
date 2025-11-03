extends CharacterBody2D

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D2

@export var gravity := 900
@export var speed := 60.0
var active := false  # se activa al tocar el suelo por primera vez
var target: Node2D = null

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	update_animation()
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if not active:
			active = true  # se activa cuando toca el suelo

	# Si está activo, moverse hacia la derecha
	var direction = (target.global_position - global_position).normalized()
	if active:
		#velocity.x = speed 
		velocity.x = direction.x * speed
	else:
		velocity.x = 0

	# Aplicar movimiento con colisiones
	move_and_slide()	
	
	
func update_animation() -> void:
	if velocity.x > 0:
		animated.flip_h = false
	elif velocity.x < 0:
		animated.flip_h = true
		
func set_target(new_target: Node2D) -> void:
	target = new_target
	
