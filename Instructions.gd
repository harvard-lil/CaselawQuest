extends Control

onready var player : KinematicBody2D = get_node("/root/MainScene/MainPlayer")

func _process(_delta):
	if self.visible:
		if Input.is_action_pressed("escape") or Input.is_action_pressed("ok")\
		or Input.is_action_pressed("action"):
			player.unfrozed()
			self.hide()
