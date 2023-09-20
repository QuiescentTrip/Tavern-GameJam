extends Area2D

class_name Bullet


var direction := Vector2.ZERO
var speed = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(direction):
	self.direction = direction
	rotation += direction.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var forward_direction = Vector2(0, -1).rotated(rotation)
#	position += forward_direction * speed * delta
	
func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity


func _on_body_entered(body):
	if(body.has_method("onkill")):
		body.onkill()
