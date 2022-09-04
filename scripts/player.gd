extends KinematicBody2D

class_name Player
var velocity:Vector2
var speed = 9000
var isMoving = false
var navMesh:Navigation2D
var path:PoolVector2Array
var point = 0
var target
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func get_class():
	return 'Player'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		$Click_Area.global_position = get_global_mouse_position()
		point = 0
		isMoving = true
		path = Navigation2DServer.map_get_path($NavigationAgent2D.get_navigation_map(), self.global_position, get_global_mouse_position(),false, 1)
		updateLine()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateLine():
	$Line2D.global_position = Vector2(0,0)
	$Line2D.points = path
	$Line2D.update()
	
func _physics_process(delta):
	if isMoving:
		setTarget()
		var length = path.size()
		velocity = (path[point] - self.global_position).normalized()
		self.move_and_slide(velocity*speed*delta)
		if self.global_position.distance_to(path[point]) < 3:
			if point < length-1:
				point += 1
			else:
				isMoving = false
				point = 0
			

func setTarget():
	var overlappedBod = $Click_Area.get_overlapping_bodies()
	if overlappedBod.size() > 0:
		for body in overlappedBod:
			if body.get_class() == 'Enemy':
				print('body')
				target = body
			if body.get_class() != 'Player':
				$Click_Area.global_position = global_position
	else:
		$Click_Area.global_position = global_position

func _on_Click_Area_body_entered(body):
	pass # Replace with function body.
