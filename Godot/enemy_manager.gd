extends Node2D

@onready var Basic_Enemy = preload("res://Enemies/Basic_Enemy.tscn")
@onready var player = get_parent().get_node("Player")


var y = round(-789.3276)
var x = round(-711.9944)
var xpos = round(1784.129)
var ypos = round(865.9188)
var rng = RandomNumberGenerator.new()
var square_chance

func _ready():
	if GlobalVariables.level > 13:
		$Timer.wait_time = 1
	else:
		$Timer.wait_time = -(0.3*GlobalVariables.level) + 4
	if GlobalVariables.level < 10:
		square_chance = 100 - GlobalVariables.level * 10
	else:
		square_chance = 25
	
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
			var chance = randi_range(1,100)
			if chance < square_chance:
				enemy.weapon = 1
			elif chance < 100 -(100 - square_chance) / 2:
				enemy.weapon = 3
			elif chance <= 100:
				enemy.weapon = 2
			add_child(enemy)
			$Timer.start()
		else:
			_on_timer_timeout()
	
