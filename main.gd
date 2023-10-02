extends Node3D

signal respawn
var checkpoints:Array
var hits = 0
var highscore = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	checkpoints = get_tree().get_nodes_in_group("checkpoint")
	for check in checkpoints:
		check.body_entered.connect(_on_checkpoint_hit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_checkpoint_hit(body):
	hits += 1
	print("ding!")

func submit_score(time):
	
	print("scored %s.%03d" % [floor(time / 1000), time % 1000])
	if checkpoints.size() <= hits && (time < highscore || highscore == 0) :
		print("New Highscore!")
		highscore = time
		get_node("%HighscoreLabel").text = "Highscore: %s.%03d" % [floor(time / 1000), time % 1000] 
	hits = 0
