extends KinematicBody

export var movement_speed: float = 5
export var mouse_sensitivity: float = 0.3
export var jump_velocity: float = 10
export var gravity: float = -30

const CAMERA_VERT_LIMIT: float = PI / 3

onready var camera: Camera = $Camera

var velocity := Vector3.ZERO
var cameraVert : float = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(deg2rad(mouse_sensitivity * -event.relative.x))
		# TODO: Tidy this up, no need for storing variables relatibe to rotation here
		var vertDelta = deg2rad(mouse_sensitivity * event.relative.y)
		var newCameraVert = cameraVert + vertDelta
		if newCameraVert > -CAMERA_VERT_LIMIT and newCameraVert < CAMERA_VERT_LIMIT:
			camera.rotate_x(vertDelta)
			cameraVert = newCameraVert


func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	move(delta)

func move(delta):
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed("jump"):
			velocity.y = jump_velocity
	elif is_on_ceiling():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	var cameraAim = get_global_transform().basis
	var motion: Vector3 = Vector3(0, 0, 0)
	if (Input.is_action_pressed('move_left')):
		motion -= cameraAim.x
	if (Input.is_action_pressed('move_right')):
		motion += cameraAim.x
	if (Input.is_action_pressed('move_up')):
		motion -= cameraAim.z
	if (Input.is_action_pressed('move_down')):
		motion += cameraAim.z
	motion.y = 0
	motion = motion.normalized()
	velocity.x = motion.x * movement_speed
	velocity.z = motion.z * movement_speed
	move_and_slide(velocity, Vector3.UP)
