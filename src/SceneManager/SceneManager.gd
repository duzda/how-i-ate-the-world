extends Node2D

var current_scene
var new_scene

var level_01 = preload("res://src/Levels/level_01.tscn");
var level_02 = preload("res://src/Levels/level_02.tscn");

signal transitioned

func _ready():
	Global.scene_manager = self
	current_scene = level_01
	new_scene = level_01
	$Transition/AnimationPlayer.play("transition_out")


func transition_scene(new_scene2):
	self.new_scene = new_scene2
	$Transition/AnimationPlayer.play("transition_in")


func reload_scene():
	self.new_scene = current_scene
	$Transition/AnimationPlayer.play("transition_in")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "transition_in":
		emit_signal("transitioned")
		$Transition/AnimationPlayer.play("transition_out")


func _on_SceneManager_transitioned():
	current_scene = new_scene
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(new_scene.instance())
