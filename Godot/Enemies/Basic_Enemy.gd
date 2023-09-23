extends CharacterBody2D


const speed = 200.0
const friction = 0.20
var team = 1
var direction

@onready var cooldown = $cooldown
@onready var end = $Marker2D
@onready var player = get_parent().get_parent().get_node("Player")

var bullet = preload("res://bullet.tscn")


func _physics_process(_delta) -> void:
	if GlobalVariables.paused == true:
		return
		
	if player != null:
		
		var distance_to = position.distance_to(player.position)
		var target = (player.position - position).normalized()
		
		if  distance_to > 300 and distance_to < 1000:
			look_at(player.global_position)
			
		direction =  target * speed
		
		if direction.length() > 1.0:
			direction = direction.normalized()
			
		if distance_to > 600 and distance_to < 1000:
				
			var target_velocity = direction * speed
			velocity += (target_velocity - velocity) * friction
				
		elif distance_to < 400:
				
			var target_velocity = -direction * speed
			velocity += (target_velocity - velocity) * friction
			
		
		move_and_slide()
			
		if($onscreen.is_on_screen()):
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
	GlobalSignals.update_coins.emit(10, false)
	queue_free()
