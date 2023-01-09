extends Node2D

onready var win_num: int = Global.win_num

onready var f_text: Label = $CenterContainer/FlavorText

onready var l1 = $Label
onready var l2 = $Label2

onready var p1 = $Paddle
onready var p2 = $Paddle2

onready var b = $Ball

func _ready() -> void:
	l1.text = str(Global.p1_score)
	l2.text = str(Global.p2_score)
	
func _process(_delta: float) -> void:
	show_f_text()
	
	if Global.end_game == true:
		if Input.is_action_just_pressed("restart"):
			f_text.text = ""
			
			Global.end_game = false
			Global.p1_score = 0
			Global.p2_score = 0
			
			b.begin_game()
			p1.begin_game()
			p2.begin_game()
		
		if Input.is_action_just_pressed("quit"):
			Global.is_pc = false
			
			Global.end_game = false
			Global.p1_score = 0
			Global.p2_score = 0
			
			f_text.text = ""
			
			var err = get_tree().change_scene("res://scn_pause.tscn")
			assert(!err, "Error!")

func show_f_text() -> void:
	l1.text = str(Global.p1_score)
	l2.text = str(Global.p2_score)
	
	if Global.p1_score == win_num - 1 or Global.p2_score == win_num - 1 :
		f_text.text = "Match Point!"
	
	elif Global.p1_score == win_num:
		f_text.text = "P1 Wins! (Press R/X to Restart, Q/C for Main Menu)"
		
		l1.text = ""
		l2.text = ""
		
		Global.end_game = true
		
	elif Global.p2_score == win_num:
		if Global.is_pc:
			f_text.text = "AI Wins! (Press R/X to Restart, Q/C for Main Menu)"
		else:
			f_text.text = "P2 Wins! (Press R/X to Restart, Q/C for Main Menu)"
		
		l1.text = ""
		l2.text = ""
		
		Global.end_game = true
