extends CharacterBody3D

var move_speed = 3
var target_velocity = Vector3.ZERO
var control_offset:int = 0
var temp_offset = control_offset
@export var collider: CollisionShape3D
@export var area_cmd: Node3D

func _ready() -> void:
	pass


func set_offset(_offset):
	temp_offset = _offset
	



func _process(delta: float) -> void:
	if Input.is_action_just_released("move_down") or Input.is_action_just_released("move_up") or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		control_offset = temp_offset

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = 10

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down") 
	print(input_dir)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
	#direction = direction.rotated(Vector3.UP, control_offset)
	
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
	#look_at(global_position + velocity, Vector3.UP)
	rotation = velocity
	move_and_slide()
