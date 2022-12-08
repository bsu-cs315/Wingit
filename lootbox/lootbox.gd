extends Node2D


var isBuying = false
var itemArray := [load("res://lootbox/lootboxLoot/food.tscn"), load("res://lootbox/lootboxLoot/metal.tscn"), load("res://MainScene/coin.tscn")]

func _ready():
	isBuying = true
	
func _process(delta):
	if isBuying == true:
		position = get_global_mouse_position()
		if Input.is_action_just_pressed("confirm_buy"):
			processBuy()
		if Input.is_action_just_pressed("cancel_buy"):
			queue_free()
		


func processBuy():
	isBuying = false
	$AnimatedSprite.play()
	


func _on_AnimatedSprite_animation_finished():
	var position0 = Vector2(position.x, position.y - 100)
	var position1 = Vector2(position.x+ 75, position.y -50)
	var position2 = Vector2(position.x -75, position.y - 50)
	var position3 = Vector2(position.x-75, position.y + 75)
	var position4 = Vector2(position.x+ 75, position.y + 75)
	var positionArray := [position0, position1, position2, position3, position4]
	for x in 5:
		randomize()
		var item = itemArray[randi() % itemArray.size()]
		var istancedItem = item.instance()
		istancedItem.position = positionArray[x]
		get_parent().add_child(istancedItem)
	$queueFreeTimer.start()


func _on_queueFreeTimer_timeout():
	queue_free()
