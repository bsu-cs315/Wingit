extends KinematicBody2D


var cost = 3
var isBought = false
var mouseInside = false
var isMoving:= false
var speed = 200
var selected = false
var movePostion
var health =10
var maxHealth = 10
var dead = false
var dmg = 5

var isWalkingToFight = false
var isFighting = false
var hittingBody

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonRoundGrey.modulate.a = .5
	$AgroRange/ButtonRoundGrey2.modulate.a =.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health == 0:
		dead = true
	if dead:
		$attackTimer.stop()
		visible = false
		$deathTimer.start()
	
	if not isFighting and not isWalkingToFight:
		hittingBody=null
	whenSelected()
	if isBought:
		if mouseInside and Input.is_action_just_pressed("confirm_buy"):
			selected = true
		if not mouseInside and Input.is_action_just_pressed("confirm_buy"):
			selected = false
	
	if not isBought:
		position = get_global_mouse_position()
		modulate.a = 0.5
		$AgroRange.visible = false
		$CollisionShape2D.visible = false
		if Input.is_action_just_pressed("confirm_buy"):
			isBought = true
			modulate.a = 1
			$AgroRange.visible = true
			$CollisionShape2D.visible = true
			get_parent().food -= cost
		if Input.is_action_just_pressed("cancel_buy"):
			queue_free()
			
	isMovingFunction(delta)
	if hittingBody != null:
		processDeadEnemy()
	processWalkingToFight(delta)
	$ProgressBar.value = (float(health)/maxHealth)*100


func _on_MeeleTroopSquad_mouse_entered():
	mouseInside = true


func _on_MeeleTroopSquad_mouse_exited():
	mouseInside = false


func isMovingFunction(delta):
	if isMoving and not isWalkingToFight:
		position = position.move_toward(movePostion, delta*speed)
	if Input.is_action_just_pressed("cancel_buy") and selected  and not isWalkingToFight and not isFighting:
		isMoving = true
		movePostion = get_global_mouse_position()


func whenSelected():
	if selected:
		$ButtonRoundGrey.visible = false
		$ArrowBeigeRight.visible = true
		$AgroRange/ButtonRoundGrey2.visible = true
	else:
		$ButtonRoundGrey.visible = true
		$ArrowBeigeRight.visible = false
		$AgroRange/ButtonRoundGrey2.visible = false

func proceesCombat():
	$attackTimer.start()


func _on_AgroRange_body_entered(body):
	if body.get_groups()[0] == "enemy":
		isWalkingToFight = true
		hittingBody = body
		proceesCombat()


func _on_Timer_timeout():
	hittingBody.health -= dmg
	

func processDeadEnemy():
	if hittingBody.dead:
		isFighting= false
		isWalkingToFight = false
		$attackTimer.stop()
		hittingBody = null
		
		
func processWalkingToFight(delta):
	if isWalkingToFight:
		position = position.move_toward(Vector2(hittingBody.position.x -95, hittingBody.position.y +25), delta*speed)


func _on_deathTimer_timeout():
	queue_free()
