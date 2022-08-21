extends Node2D


func _on_Area2D_body_entered(body):
	body.on_ladder = true


func _on_Area2D_body_exited(body):
	body.on_ladder = false
