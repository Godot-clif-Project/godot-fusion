#warning-ignore-all:unused_class_variable

extends KinematicBody2D
class_name Samus

signal state_changed

# state management
var current_state: State = null
var states_stack: Array = []

onready var states_map: Dictionary = {
	'Idle': $States/Idle,
	'FrontTurn': $States/FrontTurn,
	'Move': $States/Move,
	'JumpUp': $States/JumpUp,
	'JumpDown': $States/JumpDown,
	'JumpSpin': $States/JumpSpin,
	'FiringIdle': $States/FiringIdle,
	'FiringMove': $States/FiringMove,
}

const left_animations_map: Dictionary = {
	'Idle': 'IdleLeft',
	'Move': 'MoveLeft',
	'FrontTurn': 'FrontTurn',
	'JumpUp': 'JumpUpLeft',
	'JumpDown': 'JumpDownLeft',
	'JumpSpin': 'JumpSpinLeft',
	'FiringIdle': 'FiringIdleLeft',
	'FiringMove': 'FiringMoveLeft'
}

const right_animations_map: Dictionary = {
	'Idle': 'IdleRight',
	'Move': 'MoveRight',
	'FrontTurn': 'FrontTurn',
	'JumpUp': 'JumpUpRight',
	'JumpDown': 'JumpDownRight',
	'JumpSpin': 'JumpSpinRight',
	'FiringIdle': 'FiringIdleRight',
	'FiringMove': 'FiringMoveRight'
}

var is_looking_right: bool = false

# cache
onready var Physics2D: Node2D = $Physics2D
onready var Spawn: Node2D = $Spawn
onready var animations_map: Dictionary = left_animations_map

# velocity
var velocity: Vector2 = Vector2()
var look_direction: Vector2 = Vector2(-1, 0)

# collision/physics states
var is_grounded: bool = false
var is_on_one_way_platform: bool = false
var is_on_wall: bool = false
var snap_enable: bool = false
var gravity_enable: bool = true
var knockback_force: Vector2 = Vector2(0, 0)


func _ready() -> void:
	# Animation Player sinal
	$AnimationPlayer.connect('animation_finished', self, '_on_AnimationPlayer_animation_finished')

	# connect state with finished signal
	for state_node in $States.get_children():
		state_node.connect('finished', self, '_change_state')
		# hide sprite
		for sprite in state_node.get_children():
			if sprite is Sprite:
				sprite.hide()
		

	# default states
	states_stack.push_front(states_map['Idle'])
	current_state = states_stack[0]
	_change_state('Idle')


# Delegate the call to the state
func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


func _input(event: InputEvent) -> void:
	current_state.handle_input(self, event)


# Exit the current state, change it and enter the new one
func _change_state(state_name: String) -> void:
	current_state.exit(self)

	# hide previous animation
	current_state.hide_previous_animation(animations_map[current_state.get_name()])

	if state_name == 'Previous': # previous state
		states_stack.pop_front()
	elif state_name in ['GettingHit']: # pushdown automaton
		states_stack.push_front(states_map[state_name])
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state

	current_state = states_stack[0]

	if current_state.get_name() != 'Previous':
		current_state.set_animations(left_animations_map[current_state.get_name()], right_animations_map[current_state.get_name()])
		current_state.show_current_animation(animations_map[current_state.get_name()])
		current_state.enter(self)

	emit_signal('state_changed', states_stack)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	current_state._on_animation_finished(anim_name, self)
