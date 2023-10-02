extends Camera3D


var flight_angle = Quaternion(-0.5 , 0, 0, 0.8)
var ground_angle = Quaternion(-0.3 , 0, 0, 0.9)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().get_parent_node_3d().velocity.abs().y > 1 && transform.basis.y.dot(Vector3(0,-1,0)) < -0.2:
		rotate_x(-0.01)
		print(transform.basis.y.dot(Vector3(0,-1,0)))
		
	elif transform.basis.y.dot(Vector3(0,-1,0)) > -0.5:
			rotate_x(0.01)
	

func _physics_process(delta):
	pass
	
