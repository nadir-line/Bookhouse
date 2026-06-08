extends SpinBox


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Book_Spinbox"):
		# Prevent input from doing other thingies
		get_viewport().set_input_as_handled()
		# SpinBox is made of multiple nodes, so we must grab focus on the LineEdit according to internjet
		get_line_edit().grab_focus() 
