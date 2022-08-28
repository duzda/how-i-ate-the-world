extends Node

const creatures1 = preload("res://src/Creatures/First.tscn")
const creatures2 = preload("res://src/Creatures/Second.tscn")
const creatures3 = preload("res://src/Creatures/Third.tscn")

var creatures = [creatures1, creatures2, creatures3]

func _ready():
	Global.level += 1
	
	if Global.level == 3:
		$CanvasLayer/ResetButton.disabled = true
		$CanvasLayer/ResetButton.hide()
		$Player/End/AnimationPlayer.play("end")
		$Player/Controls.visible = false
		return
	
	$Creatures.add_child(creatures[Global.level].instance())
	
	if Global.level == 0:
		$Player/Controls/AnimationPlayer.play("controls")
		$Creatures/First.visible = true
		$Creatures/First/Fly/AnimationPlayer.play("default")
		$Creatures/First/Mole/AnimationPlayer.play("default")
	elif Global.level == 1:
		$Player/Controls.visible = false
		$Player.scale = Vector2(1.25, 1.25)
		$Player.movement_speed = 120.0
		$Player.gravitation = 800.0
		$Creatures/Second.visible = true
		$Creatures/Second/Fly/AnimationPlayer.play("default")
		$Creatures/Second/Mole/AnimationPlayer.play("default")
		$Creatures/Second/Beetle/AnimationPlayer.play("default")
	elif Global.level == 2:
		$Player/Controls.visible = false
		$Player.scale = Vector2(1.5, 1.5)
		$Player.movement_speed = 80.0
		$Player.gravitation = 1200.0
		$Creatures/Third.visible = true
		$Creatures/Third/Fly/AnimationPlayer.play("default")
		$Creatures/Third/Mole/AnimationPlayer.play("default")
		$Creatures/Third/Beetle/AnimationPlayer.play("default")


func _process(delta):
	Global.elapsed_time += delta


func _on_Hungry_body_entered(_body):
	if Global.level == 3:
		return
	
	if Global.player.food != 3:
		$Player/Hungry2/AnimationPlayer.play("hungry")


func _on_LevelEnd_body_entered(_body):
	if Global.player.food == 3:
		Global.player.blocked_controls = true
		Global.scene_manager.reload_scene()


func next_level():
	Global.scene_manager.transition_scene(Global.scene_manager.level_02)


func _on_ResetButton_pressed():
	$CanvasLayer/ResetButton.disabled = true
	Global.reset_level()
