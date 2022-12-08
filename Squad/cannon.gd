extends KinematicBody2D


var cost = 3
var hittingBodiesArray := []
var isBought = false
var dead = false
var health = 5 
var maxHealth =5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isBought:
		position = get_global_mouse_position()
		if Input.is_action_just_pressed("confirm_buy"):
			processBuy()
		if Input.is_action_just_pressed("cancel_buy"):
			queue_free()
		
	if isBought:
		$ProgressBar.value = (float(health)/maxHealth)*100
		$ProgressBar.visible = true
		var overLappingBodies = $Area2D.get_overlapping_bodies()
		processTarget(overLappingBodies)
		if hittingBodiesArray != []:
			look_at(hittingBodiesArray[0].position)
			hittingBodiesArray[0].health-=.01
			if hittingBodiesArray[0].dead == true:
				hittingBodiesArray.remove(0)
		


func processTarget(overLappingBodies):
	for i in overLappingBodies:
		if i and !hittingBodiesArray.has(i) and i.is_in_group("enemy"):
			hittingBodiesArray.append(i)
			
	


func processBuy():
	isBought = true
	get_parent().metal -= cost
