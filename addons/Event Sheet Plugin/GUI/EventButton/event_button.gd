@tool
extends Button
class_name EventButton

@export var group_label : Label
@export var condition : Label

func _on_pressed() -> void:
	print("Button pressed!")
