extends KinematicBody2D

export (PackedScene) var Bullet

var WINDOW
#var WIDTH = WINDOW.x
#var HEIGTH = WINDOW.y 
var motion = Vector2.ZERO
var speed = 20
var dir
var facing = 1
var drag = 0.95
var gravity = 9.8

func _ready():
	WINDOW = get_viewport().size

func applyPhysics():
	motion.y += gravity
	motion *= drag

func _physics_process(delta):
	dir = 0
	
	if Input.is_action_pressed("Left"):
		dir -= 1
	if Input.is_action_pressed("Right"):
		dir += 1
	if Input.is_action_just_pressed("Space") and is_on_floor():
		print("jump")
		motion.y -= 600
	
	if dir != 0:
		facing = dir
	
		
	if Input.is_action_just_pressed("LeftClick"):
		print("clicked at:", get_viewport().get_mouse_position(), " |  Player at:", get_global_transform_with_canvas())
		var bullet = Bullet.instance()
		var bulletDirection = (get_viewport().get_mouse_position() - get_global_transform_with_canvas().origin).normalized()
		bullet.global_position = global_position
		bullet.direction = bulletDirection
		get_parent().add_child(bullet)
	
	motion.x += speed * dir 
	applyPhysics()
	move_and_slide(motion, Vector2.UP)
	
	
