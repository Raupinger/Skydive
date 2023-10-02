extends Label

var timer = 0;
var running = false 
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if running:
		var time_passed = Time.get_ticks_msec() - timer
		text = "%s.%03d" % [floor(time_passed / 1000), time_passed % 1000] 
	pass


func _on_start_trigger_body_entered(body):
	print('start')
	timer = Time.get_ticks_msec()
	show()
	running = true;
	pass # Replace with function body.


func _on_end_trigger_body_entered(body):
	print('done')
	hide()
	running = false;
	get_tree().root.get_child(0).submit_score(Time.get_ticks_msec() - timer)
	pass # Replace with function body.


func _on_main_respawn():
	hide()
	running = false;
	pass # Replace with function body.
