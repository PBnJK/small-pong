extends Control

func _on_5_pressed() -> void:
	Global.win_num = 5
	var err = get_tree().change_scene("res://Level/scn_level.tscn")
	assert(!err, "Error!")

func _on_10_pressed() -> void:
	Global.win_num = 10
	var err = get_tree().change_scene("res://Level/scn_level.tscn")
	assert(!err, "Error!")

func _on_Custom_pressed() -> void:
	Global.win_num = 5
	
	Global.is_pc = true
	
	Global.pc_diff = 3
	
	var err = get_tree().change_scene("res://Level/scn_level.tscn")
	assert(!err, "Error!")

func _on_Hard_pressed() -> void:
	Global.win_num = 10
	
	Global.is_pc = true
	
	Global.pc_diff = 1
	
	var err = get_tree().change_scene("res://Level/scn_level.tscn")
	assert(!err, "Error!")

func _on_Exit_pressed() -> void:
	get_tree().quit()
