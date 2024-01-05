extends CharacterBody2D

signal laserSignal
signal grenadeSignal

var speed = 500
var laser_scene = preload("res://laser.tscn")
var grenade_scene = preload("res://grenade.tscn")

var canShoot: bool = true;
var canGrenade: bool = true;
var grenadeSpeed = 500

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
	
	if (Input.is_action_just_pressed("Action1") and canShoot): 	# Launching a lazer
		print("Shooting!")
		
		var laserInstance = laser_scene.instantiate()
		var player_direction = (get_global_mouse_position() - position).normalized() # Set direction for grenade spawn		
		laserInstance.direction = player_direction
		laserInstance.look_at(player_direction)
		laserInstance.position = laserSpawners[randi() % laserSpawners.size()].global_position
		%Projectiles.add_child(laserInstance)
		
		canShoot = false
		$Timer_Shoot.start()
		laserSignal.emit()
		
	if (Input.is_action_just_pressed("Action2") and canGrenade): # Launching a grenade
		print("Secondary Actioning!")
		ToggleIsMoving()
		canGrenade = false
		
		var grenadeInstance = grenade_scene.instantiate() as RigidBody2D
		grenadeInstance.position = laserSpawners[0].global_position
		var player_direction = (get_global_mouse_position() - position).normalized() # Set direction for grenade spawn
		
		grenadeInstance.linear_velocity = player_direction * grenadeInstance.speed
		
		%Projectiles.add_child(grenadeInstance)
		
		$Timer_Grenade.start(2)
		grenadeSignal.emit()
		
	#rotate
	look_at(get_global_mouse_position())
		
		
func ToggleIsMoving():
	$"../GameManager".ToggleIsMoving()


func _on_timer_timeout():
	canShoot = true


func _on_timer_grenade_timeout():
	canGrenade = true
