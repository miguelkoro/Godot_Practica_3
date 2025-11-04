extends CharacterBody2D

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D2


@export var gravity := 900
@export var speed := 30.0
var active := false  # se activa al tocar el suelo por primera vez
var target: Node2D = null
var isDying = false
var isAttacking = false

func _physics_process(delta: float) -> void:
	
	# Aplicar gravedad
	update_animation()
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if not active:
			active = true  # se activa cuando toca el suelo
	if not isDying and not isAttacking:
		# Si está activo, moverse hacia la derecha
		var direction = (target.global_position - global_position).normalized()
		if active:
			#velocity.x = speed 
			velocity.x = direction.x * speed
			animated.play("moving")
		else:
			velocity.x = 0
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
	
func die():
	active= false	
	isDying = true
	animated.play("dying")

func _on_animated_sprite_2d_2_animation_finished() -> void:
	if isDying:
		queue_free()
	elif isAttacking and animated.animation == "atacking":
		isAttacking = false


func _on_area_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Tank") and not isDying:
		animated.play("atacking")
		isAttacking = true
		print("HAS MUERTO")
