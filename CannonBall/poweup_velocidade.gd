extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.has_method("set_speed_powerup"):
		print_debug("AAAAAAAAAAAAAAAAAAAAA")
		body.set_speed_powerup(2000)
