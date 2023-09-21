extends CharacterBody2D


const speed = 200.0
const friction = 0.20
var team = 1
var direction

@onready var cooldown = $cooldown
@onready var player = get_parent().get_node("Player")
@onready var end = $Marker2D

var bullet = preload("res://bullet.tscn")


func _physics_process(_delta) -> void:
	if player != null:
		var distance_to = position.distance_to(player.position)
		if  distance_to > 300 and distance_to < 600:
			look_at(player.global_position)
			var target = (player.position - self.global_position).normalized()
			direction =  target * speed
			if position.distance_to(player.position) > 200:
				if direction.length() > 1.0:
					direction = direction.normalized()
				var target_velocity = direction * speed
				velocity += (target_velocity - velocity) * friction
			
				move_and_slide()
			fire()
		elif(distance_to <= 300):
			look_at(player.global_position)
			fire()
		
	

func fire():
	if cooldown.is_stopped():
		$Shot.play()
		var bullet_instance = bullet.instantiate()
		direction = (end.global_position - global_position).normalized()
		GlobalSignals.bullet_fired.emit(bullet_instance, end.global_position, direction, 1)
		cooldown.start()

func onkill():
	queue_free()
