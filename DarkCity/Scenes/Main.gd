extends Node3D
@export var current_camera: Camera3D
@export var current_area: Area3D
@export var area_cmd: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for _area in area_cmd.get_children():
		if _area is Area3D:
			_area.body_entered.connect(set_area.bind(_area))
	current_area = area_cmd.get_node("Area1")
	current_camera = current_area.get_node("Cam")

func set_area(body:Node3D,area:Area3D):
	if body is CharacterBody3D and area != current_area:
		print(area)
		current_area = area
		current_camera.current = false
		current_camera = area.get_node("Cam")
		current_camera.current = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
