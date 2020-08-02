extends Area

const BULLET_SPEED : float = 2.5

onready var forward: Vector3 = get_global_transform().basis[2].normalized() * -1

func _physics_process(delta: float) -> void:
	translation += forward * BULLET_SPEED * delta
