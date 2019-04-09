extends SamusJump

export (float) var JUMP_FORCE = 400.0

func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['JumpUp'])
	host.snap_enable = false
	host.velocity.y = -JUMP_FORCE


func handle_input(host: Samus, event: InputEvent) -> InputEvent:
	if event.is_action_released('jump'):
		host.velocity.y = -MIN_JUMP_FORCE 
	return .handle_input(host, event)


func update(host: Samus, delta: float) -> void:
	.update(host, delta)

	if host.velocity.y > 0:
		emit_signal('finished', 'JumpDown')