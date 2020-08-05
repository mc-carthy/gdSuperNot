extends KinematicBody

onready var headArea : Area = $HeadArea
onready var bodyArea : Area = $BodyArea

func hit(collider: CollisionObject) -> void:
	queue_free()
