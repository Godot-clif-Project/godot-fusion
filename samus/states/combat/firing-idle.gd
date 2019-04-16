extends Firing

const BEAM_SCENE: Resource = preload('res://samus/beam/Beam.tscn')


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['FiringIdle'])
	fire_projectile(BEAM_SCENE, host.Spawn.get_node('SpawnPosition').get_global_position(), host.look_direction, get_tree().get_root())


func _on_animation_finished(anim_name: String) -> void:
	emit_signal('finished', 'Idle')