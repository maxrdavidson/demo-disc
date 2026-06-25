extends CharacterBody3D

@export var walk_speed:int = 110
@export var run_speed:int = 250
@export var turn_speed:int = 8
var target_velocity = Vector3.ZERO
var control_offset:int = 0
var temp_offset = control_offset
@export var collider: CollisionShape3D

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
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	rotation.y -= input_dir.x * turn_speed * delta
	
	var _speed = walk_speed
	if Input.is_action_pressed("run"):
		_speed = run_speed
	var vel = -transform.basis.z * -input_dir.y * _speed * delta
	velocity.x = vel.x
	velocity.z = vel.z

	move_and_slide()
