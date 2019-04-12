extends SamusMotion
class_name SamusJump

export (float) var MIN_JUMP_FORCE = 100.0
export (float) var ACCELERATION = 0.25
export (float) var SPEED = 10.0


func handle_input(host: Samus, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('move_right') and not host.is_looking_right:
		self.get_node(left_animation).hide()
		self.get_node(right_animation).show()
		host.get_node('AnimationPlayer').play(right_animation)
	elif event.is_action_pressed('move_left') and host.is_looking_right:
		self.get_node(right_animation).hide()
		self.get_node(left_animation).show()
		host.get_node('AnimationPlayer').play(left_animation)

	return .handle_input(host, event)


func exit(host: Samus):
	self.get_node(left_animation).hide()
	self.get_node(right_animation).hide()


func update(host: Samus, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)

	move(host, input_direction, SPEED, ACCELERATION)