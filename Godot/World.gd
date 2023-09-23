extends Node2D

@onready var bullet_manager = $bullet_manager
@onready var player = $Player
@onready var song_1 = $Music1
@onready var leveltimer = $LevelTimer
@onready var gameoverscreen = preload("res://GUI/game_over.tscn")


var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.died.connect(_ondeath)

func _ondeath():
	var gameover = gameoverscreen.instantiate()
	add_child(gameover)
	


func apply_camera(delta):
	var mpos = get_global_mouse_position()
	var ppos = player.global_position
	var center = Vector2((ppos.x + mpos.x) / 2, (ppos.y + mpos.y) / 2)
	$Camera2D.global_position = center	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player != null:
		apply_camera(delta)
