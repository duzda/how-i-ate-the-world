extends Node2D

var music = [preload("res://music/Mountain View.wav"), 
	preload("res://music/Birds.wav"), preload("res://music/West Forest.wav")]

var credits = preload("res://music/Credits Theme.wav")

var music_index := 0

func _ready():
	Global.music_player = self
	play(music[music_index])


func play(music_song):
	if $AudioStreamPlayer.playing:
		$AnimationPlayer.play("transition")
		$AudioStreamPlayerMute.stream = music_song
		$AudioStreamPlayerMute.play()
	else:
		$AnimationPlayer.play("transition2")
		$AudioStreamPlayer.stream = music_song
		$AudioStreamPlayer.play()


func play_next():
	music_index += 1
	music_index %= len(music)
	play(music[music_index])


func _on_AudioStreamPlayer_finished():
	music_index += 1
	music_index %= len(music)
	if not $AudioStreamPlayer.playing and not $AudioStreamPlayerMute.playing:
		play(music[music_index])
