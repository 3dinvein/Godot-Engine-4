extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_rotation = $camera/horizontal.global_transform.basis.get_euler().y
	var input_dir = Input.get_vector("tecla_a", "tecla_d", "tecla_w", "tecla_s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, horizontal_rotation)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$character.rotation.y = lerp_angle($character.rotation.y, atan2(-direction.x, -direction.z), delta * 5)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if velocity.x != 0 or velocity.z != 0:
		$character/AnimationPlayer.play("Walk",0.2)
	elif velocity.x == 0 and velocity.z == 0:
		$character/AnimationPlayer.play("Idle",0.2)
		
	move_and_slide()
