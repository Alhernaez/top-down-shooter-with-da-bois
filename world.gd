extends Node2D



var enemy_scene = preload("res://Enemy.tscn")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var spawned_num = 0

func _on_Timer_timeout():
	spawnEnemy()
	

func spawnEnemy():
	var enemy_instance = enemy_scene.instance()
	spawned_num += 1
	enemy_instance.connect("dead", self,"_on_Enemy_dead")
	call_deferred("add_child", enemy_instance)


func _on_Enemy_dead():
	spawnEnemy()
	spawnEnemy()
