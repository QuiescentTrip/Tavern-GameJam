extends Node2D

@onready var bullet_manager = $bullet_manager
@onready var player = $Player
@onready var gameoverscreen = preload("res://GUI/game_over.tscn")
var playerload = preload("res://Player/Player.tscn")

var song_select
var song = null
var gameover = null
var color = null
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	song_select = GlobalVariables.level % 3
	song = get_node("Music" + str(song_select))
	song.play()
	GlobalSignals.died.connect(_ondeath)
	GlobalSignals.continued.connect(_continued)
	gameover = gameoverscreen.instantiate()


func _ondeath():
	song.stream_paused = true
	GlobalVariables.paused = true
	add_child(gameover)
	
func _continued():
	song.stream_paused = false
	GlobalVariables.hearts = 1
	GlobalVariables.paused = false
	remove_child(gameover)
	
func apply_camera(delta):
	var mpos = get_global_mouse_position()
	var ppos = player.global_position
	var center = Vector2((ppos.x + mpos.x) / 2, (ppos.y + mpos.y) / 2)
	$Camera2D.global_position = center	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !delta < 1/60:
		count+=0.00005
	color = Color.from_hsv(sin(count), 0.49, 0.46)
	RenderingServer.set_default_clear_color(color)

func _physics_process(delta):
	song.stream_paused = GlobalVariables.paused
	
	if player != null and !GlobalVariables.paused:
		apply_camera(delta)


func _on_level_timer_timeout():
	get_tree().change_scene_to_file("res://Shop.tscn")
