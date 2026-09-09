extends CharacterBody2D

const SPEED = 150.0

@onready var body = $Body
@onready var animated_sprite = $Body/AnimatedSprite2D
var forced_direction_x: int
var forced_direction_y: int

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")

	if direction_x and forced_direction_x == 0:
		velocity.x = direction_x * SPEED
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction_x < 0
	elif forced_direction_x != 0:
		direction_y = 0
		velocity.x = forced_direction_x * SPEED
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction_x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y and forced_direction_y == 0:
		velocity.y = direction_y * SPEED
		animated_sprite.play("walk")
	elif forced_direction_y != 0:
		direction_x = 0
		velocity.y = forced_direction_y * SPEED
		animated_sprite.play("walk")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)


	if direction_x == 0 and direction_y == 0:
		animated_sprite.play("idle")

	move_and_slide()
	if is_on_wall():
		animated_sprite.play("idle")
