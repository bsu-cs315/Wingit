extends KinematicBody2D

var maxHealth= 20
var health=10

var dead := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$ProgressBar.value = (float(health)/maxHealth)*100
