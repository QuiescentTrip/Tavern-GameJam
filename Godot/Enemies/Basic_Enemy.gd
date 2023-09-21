extends CharacterBody2D


const SPEED = 200.0

var _velocity := Vector2.ZERO
var is_in
var direction

var player

@onready var end = $Marker2D

var bullet = preload("res://bullet.tscn")


func _physics_process(delta):
	if(is_in and player != null):
		var target = (player.position - self.global_position).normalized()
		direction =  target * SPEED
		
		look_at(player.global_position)
		
		if position.distance_to(player.position) > 200:
			velocity = direction
			move_and_slide()
		var bullet_instance = bullet.instantiate()
		var direction = (end.global_position - global_position).normalized()
		GlobalSignals.bullet_fired.emit(bullet_instance, end.global_position, direction, 1)
	


func _on_area_2d_body_entered(body):
	self.player = body
	is_in = true


func _on_area_2d_body_exited(body):
	print("exited")
	is_in = false
	var velocity := Vector2.ZERO
	direction = Vector2.ZERO
	player = body
	
func onkill():
	queue_free()
