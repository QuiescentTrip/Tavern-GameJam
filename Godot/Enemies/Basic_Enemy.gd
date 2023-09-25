extends CharacterBody2D


const speed = 200.0
const friction = 0.20
var team = 1
var direction
var weapon = 0


@onready var cooldown = $cooldown
@onready var end = $Marker2D
@onready var player = get_parent().get_parent().get_node("Player")

var bullet = preload("res://bullet.tscn")

func _ready():
	match weapon:
		1:
			$Triangle.queue_free()
			$Polygon.queue_free()
		2:
			$Square.queue_free()
			$Polygon.queue_free()
		3:
			$Square.queue_free()
			$Triangle.queue_free()

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
			match weapon:
				1:
					square_fire()
				2:
					triangle_fire()
				3:
					polygon_fire()
		

var moreshots = 5
func polygon_fire():
	if $Polygon/long.is_stopped() and $Polygon/short.is_stopped():
		$Polygon/short.start()
		fire()
		moreshots -= 1
		if moreshots <= 0:
			$Polygon/long.start()
			moreshots = 5

var shots = 3
func triangle_fire():
	if $Triangle/long.is_stopped() and $Triangle/short.is_stopped():
		$Triangle/short.start()
		fire()
		shots -= 1
		if shots <= 0:
			$Triangle/long.start()
			shots = 3
		
		
func square_fire():
	if cooldown.is_stopped():
		fire()
		cooldown.start()
		
func fire():
		$Shot.play()
		var bullet_instance = bullet.instantiate()
		direction = (end.global_position - global_position).normalized()
		GlobalSignals.bullet_fired.emit(bullet_instance, end.global_position, direction, 1)

func onkill():
	GlobalVariables.score += 10
	GlobalSignals.update_coins.emit((10 * GlobalVariables.coin_multi), false)
	queue_free()
