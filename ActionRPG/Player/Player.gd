extends KinematicBody2D

const MAX_SPEED = 90
const ACCELERATION = 650
const FRICTION = 650

var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		if inputVector.x > 0:
			animationPlayer.play("RunRight")
		else:
			animationPlayer.play("RunLeft")
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
