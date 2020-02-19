extends RigidBody2D


# Declare member variables here. Examples:
export var min_speed = 150 # min speed range
export var max_speed = 250 # max speed range
var mob_types = ["walk", "swim", "fly"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
