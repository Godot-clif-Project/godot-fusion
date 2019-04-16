extends SamusFiring

const BEAM_SCENE: Resource = preload('res://samus/beam/Beam.tscn')


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['FiringMove'])
	fire_projectile(BEAM_SCENE, host)
	$FiringMoveTimer.start()


func exit(host: Samus) -> void:
	$FiringMoveTimer.stop()


func handle_input(host: Samus, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('move_right'):
		emit_signal('finished', 'FrontTurn')
	elif event.is_action_pressed('move_left'):
		emit_signal('finished', 'FrontTurn')
	elif event.is_action_pressed('jump'):
		emit_signal('finished', 'JumpSpin')
	elif event.is_action_pressed('fire'):
		fire_projectile(BEAM_SCENE, host)
		$FiringMoveTimer.start()

	return .handle_input(host, event)


#warning-ignore:unused_argument
func update(host: Samus, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)
	if not input_direction:
		emit_signal('finished', 'Idle')


# connect throught editor
func _on_FiringMoveTimer_timeout():
	emit_signal('finished', 'Move')