extends Node2D


var xSpeed = 100
var ySpeed = 0
var rightLimit = 1000
var icon;
var originalPos 
var isMoving = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func ToggleIsMoving():
	isMoving = !isMoving


func _on_player_laser_signal():
	print("laser from GameManager")


func _on_player_grenade_signal():
	print("grenade from GameManager")
