extends Area2D

class_name Bullet

var team = -1
var direction := Vector2.ZERO
var speed = 15
@onready var player = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.

func set_direction(direction):
	self.direction = direction
	rotation += direction.angle()

func _physics_process(delta):
	if GlobalVariables.paused:
		return
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity


func _on_body_entered(body):
	if(body.has_method("onkill") and body.team != self.team):
		body.onkill()
	elif self.team == 0:
		GlobalSignals.update_coins.emit(10, 1)
	queue_free()

