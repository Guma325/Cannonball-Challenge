class_name PersonagemPrincipal
extends CharacterBody2D

@onready var animations = $AnimationPlayer
@export var game_over_scene = preload("res://Game_Over/game_over.tscn") as PackedScene
@export var finish_screen_scene = preload("res://Finish_Line_Screen/finish_screen.tscn") as PackedScene


var wheel_base = 70
var steering_angle = 15
var engine_power = 1000
var friction = -55
var drag = -0.06
var braking = -450
var max_speed_reverse = 250
var slip_speed = 400
var traction_fast = 2.5
var traction_slow = 10

var acceleration = Vector2.ZERO
var steer_direction

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	
func finishline_colided():
	get_tree().change_scene_to_packed(finish_screen_scene)
	
func set_speed_powerup(speed: int):
	print_debug("Poweup - Velocidade (ON)")
	$Speed_Powerup_Timer.start()
	engine_power = speed
	
	
func poca_obstaculo():
	friction = 0
	steering_angle = 0
	
func poca_obstaculo_clear():
	friction = -55
	steering_angle = 15
	
	
func oleo_obstaculo():
	velocity = Vector2(0,0)
	animations.play("Spin")

	

func guardrail_colided():
	print("Car exploded")
	get_tree().change_scene_to_packed(game_over_scene)

func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
	
func get_input():
	var turn = Input.get_axis("steer_left", "steer_right")
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()


func _on_area_2d_body_entered(body):
	if body is TileMap:
		guardrail_colided()

func _on_speed_powerup_timer_timeout():
	print_debug("Poweup - Velocidade (OFF)")
	engine_power = 1000

