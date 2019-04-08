extends State
class_name SamusMotion


func get_input_direction() -> Vector2:
	var input_direction: Vector2 = Vector2()
	input_direction.x = int(Input.is_action_pressed('move_right')) - int(Input.is_action_pressed('move_left'))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func update_look_direction(host: Samus, direction: Vector2) -> void:
	if direction and host.look_direction != direction:
		host.look_direction = direction
		host.is_looking_right = direction.x == 1
		host.animations_map = host.right_animations_map if host.is_looking_right else host.left_animations_map
	if not direction.x in [-1, 1]:
		return


func move(host: Samus, input_direction: Vector2, speed: float, acceleration: float) -> void:
	host.velocity.x = lerp(host.velocity.x, host.look_direction.x * speed, acceleration) if input_direction else 0


func motion_less(host: Samus) -> void:
	host.velocity = Vector2() 
