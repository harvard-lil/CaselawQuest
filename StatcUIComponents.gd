extends CanvasLayer

var title : String 
var author : String

onready var instructions : Control = get_node("Instructions")
onready var player : KinematicBody2D = get_node("/root/MainScene/MainPlayer")
onready var camera : Camera2D = get_node("/root/MainScene/MainPlayer/MainCamera")
onready var title_screen : TextureRect = get_node("TitleScreen")
onready var splash_screen : Control = get_node("Splash")
onready var background : ColorRect = get_node("Background")
onready var title_label : Label = get_node("Title Label")
onready var author_label : Label = get_node("Author Label")


func start_game():
	yield(get_tree().create_timer(0.5), "timeout")
	title_screen.queue_free()
	splash_screen.queue_free()
	background.queue_free()
	player.unfrozed()
	camera.make_current()
	yield(get_tree().create_timer(1), "timeout")
	player.frozed()
	instructions.show()
	yield(get_tree().create_timer(5), "timeout")
	player.unfrozed()
	instructions.hide()

func set_title(new_title):
	title = new_title
	title_label.set_text(new_title)
	
func set_author(new_author):
	author = new_author
	author_label.set_text(new_author)
