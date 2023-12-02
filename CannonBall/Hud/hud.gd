extends Control

var seconds = 0
var miliseconds = 0

func _ready():
	var timer_label = $HBoxContainer/VBoxContainer/Timer
	timer_label.set_text("Tempo: 0")

func _on_timer_timeout():
	var timer_label = $HBoxContainer/VBoxContainer/Timer
	seconds += 1
	Global.time_e += 1
	timer_label.set_text( "Tempo: "+ str(seconds))
		
