extends KinematicBody2D

var maxHealth = 3
var health = 3
var dmg = 1
var dead = false
signal death
var hittingBody
var isFighting = false
var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonRoundGrey.modulate.a = .5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isFighting:
		position = position.move_toward(get_parent().get_node("mainBase").position, delta*speed)
	$ProgressBar.value = (float(health)/maxHealth) *100
	
	if health <=0:
		dead = true
		
		
	if dead:
		emit_signal("death")
	if hittingBody != null:
		processDeadEnemy()
	
func processCombat():
	$attackTimer.start()


func _on_attackTimer_timeout():
	hittingBody.health -= dmg


func _on_AgroRange_body_entered(body):
	if body.get_groups()[0] == "ally":
		isFighting = true
		hittingBody = body
		processCombat()


func _on_deathTimer_timeout():
	queue_free()
	
	
	


func processDeadEnemy():
	if hittingBody.dead:
		isFighting= false
		$attackTimer.stop()
		hittingBody = null


func _on_KinematicBody2D_death():
	$attackTimer.stop()
	visible = false
	$deathTimer.start()
	remove_from_group("enemy")
