extends Node

var hearts = 2
var level = 1
var coins = 0
var paused = false
var deaths = 0

var max_hearts = 2
var shield_regen = 1
var coin_multi = 1


func _ready():
	GlobalSignals.resetglobal.connect(_resetglobal)

func _resetglobal():
	hearts = 1
	max_hearts = 1
	level = 1
	coins = 0
	paused = false
	deaths = 0
