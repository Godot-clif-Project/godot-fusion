extends SamusOnGround

func enter(host: Samus) -> void:
	if host.is_looking_right:
		host.get_node('AnimationPlayer').play_backwards('FrontTurn')
	else:
		host.get_node('AnimationPlayer').play('FrontTurn')
	host.snap_enable = true
	motion_less(host)


func exit(host: Samus)-> void:
	update_look_direction(host, get_input_direction())


func _on_animation_finished(anim_name: String, host: Samus) -> void:
	assert anim_name == 'FrontTurn'
	emit_signal('finished', 'Idle')