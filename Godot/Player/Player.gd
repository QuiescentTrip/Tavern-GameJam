extends CharacterBody2D

class_name Player

var shield_degen = 2
var shield = 100

var team = 0
var speed = 500
var empty = true
var shielded = false
var invincible = false

@onready var invincible_timer = $invincible
@onready var AnimatedSprite = $AnimatedSprite2D
@onready var end = $Marker2D
var bullet = preload("res://bullet.tscn")
var paused = preload("res://Paused.tscn")
var paused_screen

var _velocity := Vector2.ZERO
func _ready():
	GlobalSignals.continued.connect(_onContinue)
	$Sprite2D.visible = not $Sprite2D.visible
	

	
func _onContinue():
	invincible = true
	$invincible2.start()
	
func _physics_process(_delta: float) -> void:
	if GlobalVariables.paused == true:
		return
		
	
	
	if shielded:
		shield = max(shield - shield_degen, 0)
	elif shield < 100 and !shielded :
		var regen = (shield + 0.25) * GlobalVariables.shield_regen
		shield = min(regen, 100)
	
	if shield <= 0:
		$Sprite2D.visible = false
		shielded = false
	
	var direction := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if invincible_timer.is_stopped() or $invincible2.is_stopped():
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
	if event.is_action_pressed("escape") and !GlobalVariables.paused:
		paused_screen = paused.instantiate()
		get_parent().add_child(paused_screen)
		GlobalVariables.paused = true
	elif event.is_action_pressed("escape") and GlobalVariables.paused  and get_parent().get_node("game_over") == null:
		get_parent().remove_child(paused_screen)
		GlobalVariables.paused = false
	
	if event.is_action_pressed("RMB") and shield >= 0:
		$Sprite2D.visible = true
		shielded = true
	elif event.is_action_released("RMB"):
		$Sprite2D.visible = false
		shielded = false
	
func onkill():
	if !empty and !shielded and !invincible:
		GlobalSignals.update_heart.emit(1, true)
		GlobalVariables.hearts -= 1
		if GlobalVariables.hearts == 0:
			GlobalVariables.deaths += 1
			GlobalSignals.died.emit()
	elif shielded:
		invincible_timer.start()
		pass
	else:
		if invincible_timer.is_stopped():
			invincible_timer.start()
			invincible = true
		if !invincible:
			$Pickup.play()
		AnimatedSprite.frame = 1
		empty = false
		

func bulletkill():
	queue_free()
	
