extends SamusJump

export (float) var JUMP_FORCE = 500.0
var check_grounded = false

func _ready():
	$JumpSpinTimer.connect('timeout', self, '_on_Timeout')


func _on_Timeout():
	check_grounded = true


func enter(host: Samus) -> void:
	host.get_node('AnimationPlayer').play(host.animations_map['JumpSpin'])
	host.snap_enable = false
	host.velocity.y = -JUMP_FORCE
	$JumpSpinTimer.wait_time = .15
	$JumpSpinTimer.start()


func handle_input(host: Samus, event: InputEvent) -> InputEvent:
	if event.is_action_released('jump') and host.velocity.y < 0:
		host.velocity.y = -MIN_JUMP_FORCE 
	return .handle_input(host, event)


func exit(host: Samus) -> void:
	check_grounded = false
	.exit(host)


func update(host: Samus, delta: float) -> void:
	.update(host, delta)

	if host.is_grounded and check_grounded:
		emit_signal('finished', 'Idle')


	