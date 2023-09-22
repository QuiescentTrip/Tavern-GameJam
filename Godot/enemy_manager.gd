extends Node2D

@onready var Basic_Enemy = preload("res://Enemies/Basic_Enemy.tscn")
@onready var player = get_parent().get_node("Player")

var y = round(1500 - 16.25)
var x = round(2400 - 577.485)
var xpos = 577
var ypos = 16
var rng = RandomNumberGenerator.new()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var pos = Vector2(randi_range(xpos, x), randi_range(ypos, y))
	if player.position.distance_to(player.position) < 500:
		var enemy = Basic_Enemy.instantiate()
		enemy.position = pos
		print(enemy.global_position)
		add_child(enemy)
		$Timer.start()
	else:
		_on_timer_timeout()
	
