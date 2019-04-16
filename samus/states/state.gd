#warning-ignore-all:unused_argument
#warning-ignore-all:unused_signal
extends Node
class_name State

signal finished(next_state_name)

var left_animation: String = ''
var right_animation: String = ''


func _ready():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)


func hide_previous_animation(animation_name: String) -> void:
	self.get_node(animation_name).hide()


func show_current_animation(animation_name: String) -> void:
	self.get_node(animation_name).show()


func set_animations(new_left_animation: String, new_right_animation) -> void:
	left_animation = new_left_animation
	right_animation = new_right_animation


# Initialize the state. E.g. change the animation
func enter(host):
	pass


# Clean up the state. Reinitialize values like a timer
func exit(host):
	pass


func handle_input(host, event):
	pass


func update(host, delta: float):
	pass


func _on_animation_finished(anim_name: String, host):
	pass


func play_sound(host, stream: Resource) -> void:
	host.get_node('AudioStreamPlayer').stream = stream
	host.get_node('AudioStreamPlayer').play()