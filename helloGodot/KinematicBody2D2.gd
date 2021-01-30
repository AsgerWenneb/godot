extends KinematicBody2D

export (PackedScene) var Bullet
export var is_active = false

onready var WINDOW = get_viewport().size

var motion = Vector2.ZERO
var speed = 20
var drag = 0.95
var gravity = 9.8



func applyPhysics():
	motion.y += gravity
	motion *= drag

func _physics_process(delta):
	var dir = 0
	
	if is_active:
		if Input.is_action_just_pressed("Shift"):
			is_active = false
	
		if Input.is_action_pressed("Left"):
			dir -= 1
		if Input.is_action_pressed("Right"):
			dir += 1
		if Input.is_action_just_pressed("Space") and is_on_floor():
			print("jump")
			motion.y -= 600
	
		if Input.is_action_just_pressed("LeftClick"):
			var bullet = Bullet.instance()
			var bulletDirection = (get_viewport().get_mouse_position() - get_global_transform_with_canvas().origin).normalized()
			bullet.global_position = global_position + bulletDirection * 20
			bullet.direction = bulletDirection
			get_parent().add_child(bullet)
	else:
		if Input.is_action_just_pressed("Shift"):
			is_active = true
	
	motion.x += speed * dir 
	applyPhysics()
	move_and_slide(motion, Vector2.UP)
