extends CharacterBody2D

class_name Player

var center = Vector2()
var damping = 12.0
var team = 0
var friction = 0.18
var speed = 400
var bulletspeed = 4000
var empty = true

@onready var end = $Marker2D
#var player = preload("res://Player/Player.tscn")
var bullet = preload("res://bullet.tscn")

var _velocity := Vector2.ZERO

func _ready():	
	#player.instantiate()
	pass
	
	
func _physics_process(_delta: float) -> void:
	apply_camera(_delta)
	var direction := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	if Input.is_action_just_pressed("LMB") and !empty:
		fire()
	
	look_at(get_global_mouse_position())

func fire():
	$Shot.play()
	var bullet_instance = bullet.instantiate()
	var direction = (end.global_position - global_position).normalized()
	GlobalSignals.bullet_fired.emit(bullet_instance, end.global_position, direction, 0)
	empty = true
	
func apply_camera(delta):
	var mpos = get_global_mouse_position()
	var ppos = global_position
	center = Vector2((ppos.x + mpos.x) / 2, (ppos.y + mpos.y) / 2)
	$Camera2D.global_position = center	
	
func onkill():
	if !empty:
		queue_free()
	else:
		empty = false

func bulletkill():
	queue_free()
	
