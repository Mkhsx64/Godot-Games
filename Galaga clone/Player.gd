extends Area2D

signal hit

# Declare member variables here. Examples:
export var speed = 250
var screen_size
var Bullet = preload("res://Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.play("right")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.play("left")
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.play("idle")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.play("idle")
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if Input.is_action_pressed("ui_accept"):
		shoot()
	else:
		$AnimatedSprite.play("idle")
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

# function to control shooting
func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)

func _on_Player_body_entered():
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false









