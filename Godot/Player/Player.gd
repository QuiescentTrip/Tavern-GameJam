extends CharacterBody2D

class_name Player

var center = Vector2()
var damping = 12.0
var team = 0
var friction = 0.18
var speed = 500
var bulletspeed = 4000
var empty = true
var shielded = false
var invincible = false
@onready var invincible_timer = $invincible
@onready var AnimatedSprite = $AnimatedSprite2D
@onready var end = $Marker2D
var bullet = preload("res://bullet.tscn")

var _velocity := Vector2.ZERO

func _ready():	
	$Sprite2D.visible = not $Sprite2D.visible
	
	
func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if invincible_timer.is_stopped():
		invincible = false
		
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	if Input.is_action_just_pressed("LMB") and !empty and !shielded:
		fire()
	
	look_at(get_global_mouse_position())

func fire():
	$Shot.play()
	AnimatedSprite.frame = 0
	var bullet_instance = bullet.instantiate()
	var direction = (end.global_position - global_position).normalized()
	GlobalSignals.bullet_fired.emit(bullet_instance, end.global_position, direction, 0)
	empty = true
	
func _input(event):
	if event.is_action_pressed("RMB"):
		$Sprite2D.visible = not $Sprite2D.visible
		shielded = true
		
	elif event.is_action_released("RMB"):
		$Sprite2D.visible = not $Sprite2D.visible
		shielded = false
	
func onkill():
	if !empty and !shielded and !invincible:
		$Death.play()
		get_tree().paused = true
		if !$Death.playing:
			queue_free()
	elif shielded:
		invincible_timer.start()
		pass
	else:
		if invincible_timer.is_stopped():
			invincible_timer.start()
			invincible = true
		$Pickup.play()
		AnimatedSprite.frame = 1
		empty = false
		

func bulletkill():
	queue_free()
	
