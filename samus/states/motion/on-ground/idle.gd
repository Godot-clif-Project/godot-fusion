extends SamusOnGround


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['Idle'])
	host.snap_enable = true
	motion_less(host)


func update(host: Samus, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x:
		if host.look_direction.x != 0 and host.look_direction.x != input_direction.x:
			emit_signal('finished', 'FrontTurn')
			update_look_direction(host, input_direction)
		else:
			emit_signal('finished', 'Move')
	# if not host.is_grounded:
	# 	emit_signal('finished', 'Fall')