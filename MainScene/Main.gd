extends Node2D

var coins = 3
var metal = 0
var food = 3
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	applyHUDChanges()
	if $mainBase.dead:
		$HUD/CanvasLayer/lostHUD.visible = true
		
	if !$mainBase.dead:
		score += 1


func _on_SpawnTimer_timeout():
	
	var enemy = load("res://Enemies/enemySquads/Enemy1Squad.tscn")
	var instancedEnemy = enemy.instance()
	var randVar = randi()%4
	if randVar == 0:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % 100+500, $mainBase.position.y + randi() % 100 +500)
	if randVar == 1:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % 100+500, $mainBase.position.y + randi() % -100 -500)
	if randVar == 2:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % -100-500, $mainBase.position.y + randi() % -100 -500)
	if randVar == 3:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % -100-500, $mainBase.position.y + randi() % 100 +500)
	
	add_child(instancedEnemy)
	
	

func applyHUDChanges():
	$HUD/CanvasLayer/coinsLabel.text = "X : " + str(coins)
	$HUD/CanvasLayer/metalLabel.text = "X : " + str(metal)
	$HUD/CanvasLayer/foodLabel.text = "X : " + str(food)
	$HUD/CanvasLayer/score.text = "Score : " +str(score)
