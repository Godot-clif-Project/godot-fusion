extends SamusFiring

const BEAM_SCENE: Resource = preload('res://samus/beam/Beam.tscn')


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['FiringIdle'])
	fire_projectile(BEAM_SCENE, host)


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_animation_finished(anim_name: String, host: Samus) -> void:
	emit_signal('finished', 'Idle')