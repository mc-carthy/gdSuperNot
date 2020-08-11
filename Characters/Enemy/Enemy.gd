extends KinematicBody

export var playerNode: NodePath

onready var headArea : Area = $HeadArea
onready var bodyArea : Area = $BodyArea

var view_dist: float = 20
var view_angle: float = 120
var _los_to_player: bool = true
var player: Node = null

func _ready() -> void:
	player = get_node(playerNode)

func _process(delta: float) -> void:
	pass

func hit(collider: CollisionObject) -> void:
	queue_free()

func can_see(target: Spatial) -> bool:
	if _is_in_view_range(target):
		if _is_in_view_angle(target):
			if _has_los(target):
				return true
	return false

func _is_in_view_range(target: Spatial) -> bool:
	var sqr_dist: float = global_transform.origin.distance_squared_to(target.global_transform.origin)
	return sqr_dist < pow(view_dist, 2)

func _is_in_view_angle(target: Spatial) -> bool:
	var forward_unit_vertor: Vector3 = global_transform.basis.z
	var target_direction_unit_vector: Vector3 = global_transform.origin.direction_to(target.global_transform.origin)
	var dot: float = forward_unit_vertor.dot(target_direction_unit_vector)
	return acos(dot) < deg2rad(view_angle / 2)

func _has_los(target: Spatial) -> bool:
	return _los_to_player
