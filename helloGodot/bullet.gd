extends Area2D

var velocity = 1000
var direction

func _physics_process(delta):
	position += velocity * delta * direction
