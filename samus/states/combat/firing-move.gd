extends SamusFiring

const BEAM_SCENE: Resource = preload('res://samus/beam/Beam.tscn')


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['FiringMove'])
	fire_projectile(BEAM_SCENE, host.Spawn.get_node('SpawnPosition').get_global_position(), host.look_direction, get_tree().get_root())


func update(host: Samus, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)
	if not input_direction:
		emit_signal('finished', 'Idle')


func _on_animation_finished(anim_name: String, host: Samus) -> void:
	emit_signal('finished', 'Move')