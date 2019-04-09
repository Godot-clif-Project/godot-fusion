extends SamusOnGround

func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play('FrontTurn')
	host.snap_enable = true
	motion_less(host)


func exit(host: Samus)-> void:
	update_look_direction(host, get_input_direction())


func _on_animation_finished(anim_name: String) -> void:
	assert anim_name == 'FrontTurn'
	emit_signal('finished', 'Idle')