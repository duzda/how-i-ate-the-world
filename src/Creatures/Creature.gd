extends Area2D


func _on_Creature_body_entered(body):
	body.eat()
	queue_free()
