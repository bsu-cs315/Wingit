extends Node2D


var foodSprites := [load("res://lootbox/lootboxLoot/79_pancakes.png"),load("res://lootbox/lootboxLoot/81_pizza.png"),load("res://lootbox/lootboxLoot/95_steak.png"),load("res://lootbox/lootboxLoot/97_sushi.png"),load("res://lootbox/lootboxLoot/99_taco.png"),load("res://lootbox/lootboxLoot/101_waffle.png")]

func _ready():
	$KinematicBody2D/Pearl01a.modulate.a = .3
	randomize()
	$KinematicBody2D/foodSprite.texture = foodSprites[randi() % foodSprites.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KinematicBody2D_mouse_entered():
	get_parent().food += 1
	queue_free()
