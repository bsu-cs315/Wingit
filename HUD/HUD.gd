extends Node2D

var isbuying = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isbuying and Input.is_action_just_pressed("cancel_buy") or Input.is_action_just_pressed("confirm_buy"):
		isbuying = false

func _on_MeleeTroopButton_button_up():
	if isbuying == false and get_parent().food >= 3:
		isbuying = true
		var instancedMeleeTroop = load("res://Squad/MeeleTroopSquad.tscn")
		var troop = instancedMeleeTroop.instance()
		troop.position = get_global_mouse_position()
		get_parent().add_child(troop)


func _on_buyLootButton_mouse_entered():
	$CanvasLayer/buyLootButton/BronzeCoin.visible = true
	$CanvasLayer/buyLootButton/Label.visible = true
	

func _on_buyLootButton_mouse_exited():
	$CanvasLayer/buyLootButton/BronzeCoin.visible = false
	$CanvasLayer/buyLootButton/Label.visible = false


func _on_buyLootButton_button_up():
	if isbuying == false and get_parent().coins >= 5:
		isbuying = true
		var instancedLootBox = load("res://lootbox/lootbox.tscn")
		var lootBox = instancedLootBox.instance()
		lootBox.position = get_global_mouse_position()
		get_parent().add_child(lootBox)


func _on_workerTroopButton_button_up() :
	if isbuying == false and get_parent().coins >= 3:
		isbuying = true
		var instancedMeleeTroop = load("res://Squad/workerTroopSquad.tscn")
		var troop = instancedMeleeTroop.instance()
		troop.position = get_global_mouse_position()
		get_parent().add_child(troop)


func _on_cannonBuyButton_button_up():
	if isbuying == false and get_parent().metal >= 3:
		isbuying= true
		var instancedCannon = load("res://Squad/cannon.tscn")
		var cannon = instancedCannon.instance()
		cannon.position = get_global_mouse_position()
		get_parent().add_child(cannon)


func _on_workerTroopButton_mouse_entered():
	$CanvasLayer/buyWorkerLabel.visible=true


func _on_workerTroopButton_mouse_exited():
	$CanvasLayer/buyWorkerLabel.visible=false


func _on_MeleeTroopButton_mouse_entered():
	$CanvasLayer/buyFighterLabel.visible= true


func _on_MeleeTroopButton_mouse_exited():
	$CanvasLayer/buyFighterLabel.visible= false


func _on_cannonBuyButton_mouse_entered():
	$CanvasLayer/buyCannonLabel.visible = true


func _on_cannonBuyButton_mouse_exited():
	$CanvasLayer/buyCannonLabel.visible = false


func _on_mainMenuButton_button_up():
	get_tree().change_scene("res://MainMenu/mainMenu.tscn")


func _on_restartButton_button_up():
	get_tree().change_scene("res://MainScene/Main.tscn")
