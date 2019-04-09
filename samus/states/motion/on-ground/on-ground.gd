extends SamusMotion
class_name SamusOnGround


func handle_input(host: Samus, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('jump') and not host.velocity.x:
		emit_signal('finished', 'JumpUp')
	elif event.is_action_pressed('jump') and host.velocity.x:
		emit_signal('finished', 'JumpSpin')

	return .handle_input(host, event)