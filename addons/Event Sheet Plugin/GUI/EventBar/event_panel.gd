@tool
extends MarginContainer
class_name EventPanel

signal selected(panel : EventPanel)


func _on_mouse_entered() -> void:
	selected.emit(self)


func _on_mouse_exited() -> void:
	pass # Replace with function body.
