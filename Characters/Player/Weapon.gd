extends Spatial

var projectile_bullet_scene = load("res://Weapons/Bullet.tscn")

func fire() -> void:
	var projectile_bullet = projectile_bullet_scene.instance()
	self.add_child(projectile_bullet)
	projectile_bullet.set_as_toplevel(true)
	projectile_bullet.global_transform = self.global_transform
