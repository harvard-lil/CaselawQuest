extends KinematicBody2D

var score : int = 0

var run_speed : int = 600
var speed : int = 200
var jumpForce : int = 600
var gravity : int = 800
var am_i_frozed : bool = true
var in_air : bool = false

var vel : Vector2 = Vector2()

onready var sprite : AnimatedSprite = get_node("Sprite")

var proximity : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("stopped")
	
func register_proximity(item):
	if item in proximity:
		proximity.erase(item)
	proximity.push_front(item)

func unregister_proximity(item):
	proximity.erase(item)
	
func _physics_process(delta):

	vel.x = 0
	if not am_i_frozed:
		if Input.is_action_just_pressed("move_left") or \
		Input.is_action_just_pressed("move_right"):
			sprite.play("moving")
			
		if Input.is_action_just_released("move_right") or \
		Input.is_action_just_released("move_left"):
			sprite.play("stopped")
		
		if Input.is_action_pressed("move_left"):
			if Input.is_action_pressed("run toggle"):
				vel.x -= run_speed 
				sprite.play("running")
			else:
				vel.x -= speed 
				sprite.play("moving")
		
		if Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("run toggle"):
				vel.x += run_speed 
				sprite.play("running")
			else:
				vel.x += speed 
				sprite.play("moving")
			
		var current_gravity : int = gravity
		if Input.is_action_pressed("fall faster"):
			current_gravity = gravity * 7
		
		# Move Player
		vel = move_and_slide(vel, Vector2.UP)
		vel.y += current_gravity * delta
		
		if in_air and is_on_floor():
			in_air = false
			sprite.play("landing")
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			vel.y -= jumpForce
			in_air = true
			sprite.play("jumping")
			
		if Input.is_action_just_pressed("action"): # brings up and closes dialogs
			if proximity.size() > 0:
				self.frozed()
				proximity[0].showDialog()
	else:
		if (Input.is_action_just_pressed("action") \
		or Input.is_action_just_pressed("ok") \
		or Input.is_action_just_pressed("escape")) \
		and proximity.size() > 0: 
			self.unfrozed()
			proximity[0].hideDialog()

func frozed():
	am_i_frozed = true
	
func unfrozed():
	am_i_frozed = false
	
func toggle_hidden():
	if self.visible:
		self.hide()
	else:
		self.show()
