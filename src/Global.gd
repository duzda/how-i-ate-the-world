extends Node

var scene_manager
var player
var level = -1
var elapsed_time = 0
var music_player

func game_over():
	scene_manager.reload_scene()


func push_player():
	player.push()


func reset_game():
	Global.level = -1
	Global.elapsed_time = 0
	scene_manager.transition_scene(scene_manager.level_01)
	music_player.play_next()
