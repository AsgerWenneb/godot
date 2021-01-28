extends RigidBody2D

var motion = Vector2.ZERO
var speed = 50
var dir = Vector2.ZERO
var drag = 0.1

func _ready():
	mode = RigidBody2D.MODE_CHARACTER

func _integrate_forces(state):
	dir = Vector2.ZERO
	
	if (Input.is_action_pressed("Up")):
		dir.y -= 1
	if (Input.is_action_pressed("Down")):
		dir.y += 1
	if (Input.is_action_pressed("Left")):
		dir.x -= 1
	if (Input.is_action_pressed("Right")):
		dir.x += 1
	
	add_central_force(dir * speed - get_applied_force() * drag)
	
