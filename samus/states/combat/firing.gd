extends SamusMotion
class_name SamusFiring


func fire_projectile(scene:Resource, host: Samus) -> void:
	var projectile = scene.instance()
	var SpawnPosition: Position2D = host.Spawn.get_node('SpawnPosition')
	projectile.position = SpawnPosition.get_global_position()
	projectile.set_direction(host.look_direction)
	get_tree().get_root().add_child(projectile)

	host.Spawn.get_node('Firing').show()
	host.Spawn.get_node('Firing').play()