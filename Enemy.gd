extends KinematicBody2D

signal dead

var motion = Vector2()
func _init():
	randomize()
	var x_range = Vector2(-4000, 4000)
	var y_range = Vector2(-4000, 4000)
	var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	var random_pos = Vector2(random_x, random_y)
	position=random_pos

	
func _ready():
	pass

func _physics_process(delta):
	var Player = get_parent().get_node("player")
	position += (Player.position - position)/30
	look_at(Player.position)
	move_and_collide(motion)


func _on_Area2D_body_entered(body):
	if "Proyectile" in body.name:
		emit_signal("dead")
		queue_free()
