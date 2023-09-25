extends Node

var hearts = 3
var level = 1
var coins = 0
var paused = false
var deaths = 0

var max_hearts = 3
var shield_regen = 1
var coin_multi = 1
var score = 0

func _ready():
	GlobalSignals.resetglobal.connect(_resetglobal)

func _resetglobal():
	shield_regen = 1
	coin_multi = 1
	hearts = 3
	max_hearts = 3
	level = 1
	coins = 0
	paused = false
	deaths = 0
	score = 0
