extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const DRAG_BASE = 0.016

var DIVE_ANGLE = Quaternion(-0.5 , 0, 0, 0.9).normalized()
var BASE_ANGLE = Quaternion(0 , 0, 0, 1).normalized()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
	
	var mesh = self.get_child(1)
	if Input.is_action_pressed("dive"):
		mesh.transform.basis = Basis(Quaternion(mesh.transform.basis).slerp(DIVE_ANGLE, 0.5).normalized())
	else :
		mesh.transform.basis = Basis(Quaternion(mesh.transform.basis).slerp(BASE_ANGLE, 0.5).normalized())
	
	
func _physics_process(delta):
	# Add the gravity.
	var initial_v = velocity.y;
	if not is_on_floor():
		velocity.y -= gravity * delta
	#simple drag model
	var drag_fac = DRAG_BASE
	if Input.is_action_pressed("dive"):
		drag_fac = drag_fac/5
		
	var drag = initial_v * initial_v * drag_fac * delta
	velocity.y += drag
	velocity.y = min(velocity.y, 0)
	#print('velocity: %s, gravity: %s, drag: %s' % [initial_v, gravity * delta, drag])

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("tilt_left", "tilt_right", "tilt_forward", "tilt_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()




func _on_end_trigger_body_exited(body):
	_on_main_respawn()


func _on_main_respawn():
	print('teleport')
	position = Vector3(2,5,10)
	pass # Replace with function body.
