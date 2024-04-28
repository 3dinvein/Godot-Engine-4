extends Node3D

@export var sensibilidade := 0.2
@export var aceleracao := 10

const  MIN := -300
const  MAX := 250

var cam_hor := 0.0
var cam_vert := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		cam_hor -= event.relative.x * sensibilidade
		cam_vert -= event.relative.y * sensibilidade
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func  _physics_process(delta):
	cam_vert = clamp(cam_vert, MIN, MAX)
	$horizontal.rotation_degrees.y = lerp($horizontal.rotation_degrees.y, cam_hor, aceleracao * delta)
	$horizontal/vertical.rotation_degrees.x = lerp($horizontal.rotation_degrees.x, cam_vert, aceleracao * delta)
