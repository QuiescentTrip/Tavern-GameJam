extends CharacterBody2D


const SPEED = 300.0

var _velocity := Vector2.ZERO



func _physics_process(delta):
	move_and_slide()


func _on_area_2d_body_entered(body):
	var direction = (body.global_position - self.global_position)
	print(direction)
	
	
