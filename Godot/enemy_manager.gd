extends Node2D

@onready var Basic_Enemy = preload("res://Enemies/Basic_Enemy.tscn")
@onready var player = get_parent().get_node("Player")


var y = round(-789.3276)
var x = round(-711.9944)
var xpos = round(1784.129)
var ypos = round(865.9188)
var rng = RandomNumberGenerator.new()

func _ready():
	$Timer.wait_time = GlobalVariables.level

func _physics_process(delta):
	if GlobalVariables.paused:
		$Timer.paused = true
	else:
		$Timer.paused = false


func _on_timer_timeout():
	if player != null:
		var pos = Vector2(randi_range(xpos, x), randi_range(ypos, y))
		if pos.distance_to(player.position) > 600:
			var enemy = Basic_Enemy.instantiate()
			enemy.position = pos
			add_child(enemy)
			$Timer.start()
		else:
			_on_timer_timeout()
	
