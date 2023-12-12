extends Sprite2D

var test_scale: int = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	test_scale = 2
	#scale = Vector2(test_scale, test_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#scale += Vector2(0.1, 0.1)
