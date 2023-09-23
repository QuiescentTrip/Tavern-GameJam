extends Control

@onready var full_hearts = $Empty_hearts
@onready var empty_hearts = $Full_hearts


# Called when the node enters the scene tree for the first time.
func _ready():
	empty_hearts.size.x = 32 * GlobalVariables.max_hearts
	full_hearts.size.x = 32 * GlobalVariables.hearts
	GlobalSignals.update_heart.connect(_update_hearts)
	

func _update_hearts(hearts, negative):
	if negative:
		full_hearts.size.x -= 32 * hearts
	if !negative:
		full_hearts.size.x += 32 * hearts


