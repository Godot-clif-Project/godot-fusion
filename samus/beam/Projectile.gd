extends Area2D

var PROJECTILE_SPEED: int = 500
var direction: Vector2 = Vector2(1, 0) setget set_direction
var update_motion: bool = true


func _ready():
	self.connect('body_entered', self, '_on_Body_entered')
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$Beam.scale.x = direction.x * -1


func _process(delta: float) -> void:
	if update_motion:
		var motion: Vector2 = direction * PROJECTILE_SPEED
		set_position(get_position() + motion * delta)


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	$Beam.scale.x = new_direction.x


func _on_Body_entered(body: Object) -> void:
	if body.get_collision_mask_bit(0):
		update_motion = false
		$AnimationPlayer.play('Explode')


func _on_Animation_finished(anim_name: String) -> void:
	if anim_name == 'Explode':
		queue_free()