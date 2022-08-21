extends Node2D


func _ready():
	$Time.text = _format_time(Global.elapsed_time)
	Global.music_player.play(Global.music_player.credits)


func _format_time(time: float):
	var minutes := time / 60
	var seconds := fmod(time, 60)
	var milliseconds := fmod(time, 1) * 100

	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]

func _input(event):
	if event.is_action_pressed("ui_accept"):
		Global.reset_game()
