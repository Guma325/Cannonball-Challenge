class_name MainMenu
extends Control


@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/Quit_Button as Button

@export var start_level = preload("res://world.tscn")
