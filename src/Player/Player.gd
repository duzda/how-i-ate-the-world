extends KinematicBody2D

export (float) var movement_speed = 160.0
export (float) var ladder_speed = 80.0
export (float) var friction = 0.2
export (float) var acceleration = 0.25
export (float) var gravitation = 600.0
export (float) var jump_speed = -270.0
export (float) var player_push = -400.0

var on_ladder := false
var blocked_controls := false
var food := 0

var last_grounded := true
var velocity = Vector2()

func _ready():
	Global.player = self
	
	if Global.level == 2:
		$Sprite.visible = false


func get_input() -> Vector2:
	var return_vector := Vector2()
	
	if Input.is_action_pressed("ui_up"):
		return_vector -= Vector2(0.0, 1.0)
	if Input.is_action_pressed("ui_down"):
		return_vector += Vector2(0.0, 1.0)
	if Input.is_action_pressed("ui_left"):
		return_vector -= Vector2(1.0, 0.0)
	if Input.is_action_pressed("ui_right"):
		return_vector += Vector2(1.0, 0.0)
	
	return return_vector


func get_vertical_input() -> Vector2:
	var return_vector := Vector2()
	
	if Input.is_action_pressed("ui_up"):
		return_vector -= Vector2(0.0, 1.0)
	if Input.is_action_pressed("ui_down"):
		return_vector += Vector2(0.0, 1.0)
	
	return return_vector


func _physics_process(_delta) -> void:
	if blocked_controls:
		$Sprite.animation = "idle"
		return
	
	var direction = get_input()
	
	if not last_grounded and is_on_floor():
		$ImpactSound.play()
	
	if direction.x != 0.0:
		velocity.x = lerp(velocity.x, direction.x * movement_speed, acceleration)
		$Sprite.flip_h = direction.x > 0
		$Sprite.animation = "walk"
		if is_on_floor() and not $StepSound.playing:
			$StepSound.play()
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		$Sprite.animation = "idle"
	
	
	if on_ladder:
		if direction.y != 0.0:
			velocity.y = lerp(velocity.y, direction.y * ladder_speed, acceleration)
			if not $LadderSound.playing:
				$LadderSound.play()
			$Sprite.animation = "walk"
		else:
			velocity.y = lerp(velocity.y, 0, friction)
			$Sprite.animation = "idle"
	
	
	if not on_ladder:
		velocity.y += gravitation * _delta
		
		if Input.is_action_just_pressed("ui_up"):
			if is_on_floor():
				velocity.y = jump_speed
				$JumpSound.play()
	
	last_grounded = is_on_floor()
	
	velocity = move_and_slide(velocity, Vector2.UP)


func push():
	velocity.y = player_push
	$JumpSound.play()


func eat():
	food += 1
	$FoodSound.play()
