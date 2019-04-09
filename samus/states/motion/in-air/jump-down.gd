extends SamusJump


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['JumpDown'])
	host.snap_enable = true


func update(host: Samus, delta: float) -> void:
	.update(host, delta)

	if host.is_grounded:
		emit_signal('finished', 'Idle')
	