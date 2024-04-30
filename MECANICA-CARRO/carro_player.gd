extends VehicleBody3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = Input.get_axis("tecla_d","tecla_a") * 0.2
	engine_force = Input.get_axis("tecla_s","tecla_w") * 200
	pass
