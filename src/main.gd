extends Node2D

@onready var mobSpawnTimer = $MobSpawnTimer
var spawn_time := 0.5
var mobScene = load('res://src/mob.tscn')
var score := 0

func _ready()->void:
	mobSpawnTimer.timeout.connect(spawn_mob)
	mobSpawnTimer.wait_time = spawn_time
	mobSpawnTimer.start()
	pass
	
func spawn_mob() -> void:
	var mob = mobScene.instantiate() #makes instance of mob
	var mobSpawnLocation := $MobSpawnPath/MobLocation #finds reference of mob location
	mobSpawnLocation.progress_ratio = randf() #find random line of perimeter
	mob.position = mobSpawnLocation.position #set mob location to random locaiton
	var direction = mobSpawnLocation.rotation + PI/2 #makes mob direction face screen
	direction += randf_range(-PI/4,PI/4)	
	mob.angle = Vector2.RIGHT.rotated(direction)
	mob.speed = randf_range(100,200)	#gives random speed
	mob.died.connect(update_score)
	add_child(mob)
	
func update_score():
	score +=1
	var scoreLabel = $Label
	scoreLabel.text="SCORE: "+ str(score)
