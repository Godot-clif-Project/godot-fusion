extends Label


func _ready() -> void:
	#warning-ignore:return_value_discarded
	$'..'.connect('state_changed', self, '_on_Samus_state_changed')


func _on_Samus_state_changed(states_stack: Array) -> void:
	text = states_stack[0].get_name()
