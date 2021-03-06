extends Node2D


# Declare member variables here. Examples:
export (PackedScene) var Mob
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func _new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_MobTimer_timeout():
	# choose a random location on path2d.
	$MobPath/MobSpawnLocation.set_offset(randi())
	# create a mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# set the mob's direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# set the mob's position to a rnadom location.
	mob.position = $MobPath/MobSpawnLocation.position
	# add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# set the velocity ( speed and direction )
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


