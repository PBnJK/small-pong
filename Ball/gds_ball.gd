extends Area2D

const MOVE_SPEED: int = 5

var velo_x: int
var velo_y: int

onready var l1 = get_parent().get_node("Label")
onready var l2 = get_parent().get_node("Label2")

onready var p1 = get_parent().get_node("Paddle")
onready var p2 = get_parent().get_node("Paddle2")

onready var beeper = get_parent().get_node("Beeper")

func _ready() -> void:
	begin_game()
	randomize()
	
func _physics_process(_delta: float) -> void:
	if !Global.end_game:
		position += Vector2(velo_x, velo_y)

func _on_Ball_body_entered(body: Node) -> void:
	beep()

	if body.name == "TopCol":
		velo_y = MOVE_SPEED
	elif body.name == "BottomCol":
		velo_y = -MOVE_SPEED
	elif body.name == "Paddle":
		velo_x = MOVE_SPEED
	elif body.name == "Paddle2":
		velo_x = -MOVE_SPEED

func _on_Ball_area_entered(area: Area2D) -> void:	
	if area.name == "P1Wins":
		Global.p1_score += 1
		
	elif area.name == "P2Wins":
		Global.p2_score += 1
	
	begin_game()

func begin_game() -> void:
	velo_x = 0; velo_y = 0
	position = Vector2.ZERO
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	velo_x = pick_random(MOVE_SPEED, -MOVE_SPEED); velo_y = pick_random(MOVE_SPEED, -MOVE_SPEED)
	
func pick_random(a, b) -> int:
	var r = randf()
	if r < 0.5:
		return a
	else:
		return b

func beep() -> void:
	var sq = AudioStreamSample.new()
	sq.format = AudioStreamSample.FORMAT_8_BITS
	sq.mix_rate = 44100
	
	var data: PoolByteArray = PoolByteArray([])
	var length: float = 8820.0
	var phase = 0.0
	var increment: float = 0.0181406
	
	for i in range(length):
		var percent = i/length
		var LFO = increment * -sin(percent * TAU) * 10 + phase
		
		var byte = (128.0 * pow(1 - percent, 4) * sin(TAU * LFO))
		phase = fmod(phase + increment, 1.0)
		
		data.append(byte)
		
	sq.data = data
	beeper.stream = sq
	
	beeper.play()
