const left_animations_list: Dictionary = {
  'Idle': 'IdleLeft',
  'Move': 'MoveLeft'
}


const right_animations_list: Dictionary = {
  'Idle': 'IdleRight',
  'Move': 'MoveRight'
}


static func get_animations_list(is_looking_right: bool) -> Dictionary:
	return right_animations_list if is_looking_right else left_animations_list
