extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$KinematicBody2D/Pearl01a.modulate.a = .3


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KinematicBody2D_mouse_entered():
	get_parent().metal += 1
	queue_free()
