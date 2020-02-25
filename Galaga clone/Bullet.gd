extends KinematicBody2D


# Declare member variables here. Examples:
var speed = 750
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
#func _ready():

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
