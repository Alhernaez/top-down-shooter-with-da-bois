extends KinematicBody2D

const ACCELERATION = 1500
const MAX_VELOCITY = 500
const FRICTION = 2000

var velocity = Vector2.ZERO
var bullet_speed = 5000
var bullet = preload("res://Proyectile.tscn")


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_VELOCITY, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("LMB"):
		fire()
		
func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position =  get_global_position() #+ Vector2(20,20)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0 ).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)


func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
