extends Camera3D


var flight_angle = Quaternion(-0.55 , 0, 0, 0.8).normalized()
var fligth_pos = Vector3(0, 4, 0.6);
var ground_angle = Quaternion(-0.3 , 0, 0, 0.9).normalized()
var ground_pos = Vector3(0, 2, 2);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	
	if get_parent().get_parent_node_3d().velocity.abs().y > 1:
		var current_rot = Quaternion(transform.basis)
		transform.basis = Basis(current_rot.slerp(flight_angle, 0.5).normalized())
		position = position.slerp(fligth_pos, 0.5)
		
		
	else:
		var current_rot = Quaternion(transform.basis)
		transform.basis = Basis(current_rot.slerp(ground_angle, 0.2).normalized())
		position = position.slerp(ground_pos, 0.1)
	
	
