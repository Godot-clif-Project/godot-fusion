extends SamusMotion
class_name SamusFiring


func fire_projectile(scene:Resource, global_position: Vector2, direction: Vector2, node: Node) -> void:
	var projectile = scene.instance()
	projectile.position = global_position
	projectile.set_direction(direction)
	node.add_child(projectile)