extends KinematicBody2D

const MOVE_SPEED: float = 200.0

export var player_id: int

var is_pc: bool = Global.is_pc
var pc_diff: int = Global.pc_diff

var velocity: Vector2 = Vector2.ZERO
var p_input: Vector2 = Vector2.ZERO

onready var m_up = str(player_id) + "_move_up"
onready var m_down =  str(player_id) + "_move_down"

onready var b = get_parent().get_node("Ball")

func _unhandled_input(_event: InputEvent) -> void:
	if !is_pc or player_id == 0:
		get_player_input()
	
func _physics_process(delta: float) -> void:
	if !Global.end_game:
		if is_pc and player_id == 1:
			move_ai(delta)
		else:
			move(delta)
	
func begin_game() -> void:
	position.y = 0
	
func move(_delta: float) -> void:
	if p_input != Vector2.ZERO:
		velocity = p_input * MOVE_SPEED
		
		velocity = move_and_slide(velocity, Vector2.UP)

func move_ai(delta: float):
	if b.position.x > -128:
		
		if (b.position.y - position.y) < -pc_diff:
			p_input = Vector2(0.0, -1.0)
		elif (b.position.y - position.y) > pc_diff:
			p_input = Vector2(0.0, 1.0)
		else:
			p_input = Vector2.ZERO
			
		move(delta)
	
func get_player_input() -> void:
	p_input = Vector2(0.0, Input.get_axis(m_up, m_down))
	
