extends CharacterBody2D

signal laserSignal
signal grenadeSignal

var speed = 500
var laser_scene = preload("res://laser.tscn")

var canShoot: bool = true;
var canGrenade: bool = true;

var laserSpawners

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	laserSpawners = $LaserSpawners.get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	#position += direction * speed * delta
	velocity = direction * speed
	move_and_slide()
	
	if (Input.is_action_just_pressed("Action1") and canShoot):
		print("Shooting!")
		var laserInstance = laser_scene.instantiate()
		laserInstance.position = laserSpawners[randi() % laserSpawners.size()].global_position
		%Projectiles.add_child(laserInstance)
		canShoot = false
		$Timer_Shoot.start()
		laserSignal.emit()
		
	if (Input.is_action_just_pressed("Action2") and canGrenade):
		print("Secondary Actioning!")
		ToggleIsMoving()
		canGrenade = false
		$Timer_Grenade.start(2)
		grenadeSignal.emit()
		
		
func ToggleIsMoving():
	$"../GameManager".ToggleIsMoving()


func _on_timer_timeout():
	canShoot = true


func _on_timer_grenade_timeout():
	canGrenade = true
