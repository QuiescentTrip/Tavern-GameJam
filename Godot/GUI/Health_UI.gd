extends CanvasLayer

@onready var full_hearts = $Full_hearts
@onready var empty_hearts = $Empty_hearts


# Called when the node enters the scene tree for the first time.
func _ready():
	full_hearts.hide()
	print(GlobalVariables.max_hearts)
	#empty_hearts.size.x = 32 * GlobalVariables.max_hearts
	#full_hearts.size.x = 32 * GlobalVariables.hearts
	GlobalSignals.update_heart.connect(_update_hearts)
	

func _update_hearts(hearts, negative):
	if negative:
		full_hearts.size.x -= 32 * hearts
	if !negative:
		full_hearts.size.x += 32 * hearts


