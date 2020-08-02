extends Area

const BULLET_SPEED : float = 2.5

onready var forward: Vector3 = get_global_transform().basis[2].normalized() * -1

func _ready() -> void:
	connect('area_entered', self, '_on_area_entered')
	connect('body_entered', self, '_on_body_entered')

func _physics_process(delta: float) -> void:
	translation += forward * BULLET_SPEED * delta

func _on_area_entered(area: Area) -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	queue_free()
