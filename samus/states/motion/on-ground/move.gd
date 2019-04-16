extends SamusOnGround


# pixels/sec
const SPEED: float = 150.0 
const ACCELERATION: float = 1.0

var direction_at_enter: Vector2 = Vector2()


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['Move'])
	direction_at_enter = host.look_direction
	host.snap_enable = true


func handle_input(host: Samus, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('move_right'):
		emit_signal('finished', 'FrontTurn')
	elif event.is_action_pressed('move_left'):
		emit_signal('finished', 'FrontTurn')
	elif event.is_action_pressed('fire'):
		emit_signal('finished', 'FiringMove')

	return .handle_input(host, event)


#warning-ignore:unused_argument
func update(host: Samus, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)
	if not input_direction:
		emit_signal('finished', 'Idle')
	
	move(host, input_direction, SPEED, ACCELERATION)
