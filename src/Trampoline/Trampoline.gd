extends Node2D


func push_player():
	Global.push_player()


func _on_Area2D_body_entered(_body):
	$StaticBody2D/AnimationPlayer.play("push", -1, 8)
