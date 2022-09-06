extends KinematicBody2D

class_name Enemy
var velocity:Vector2
var speed = 9000
var isMoving = false
var navMesh:Navigation2D
var path:PoolVector2Array
var point = 0
var health = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func get_class():
	return 'Enemy'
func getDamage(damage):
	health -= damage
	$Health.value = health
	if health <= 0:
		$AnimatedSprite.play("dead")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
