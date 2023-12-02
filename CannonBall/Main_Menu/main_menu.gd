class_name MainMenu
extends Control


@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/Quit_Button as Button

@export var start_level = preload("res://world.tscn")

func _ready():
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()
