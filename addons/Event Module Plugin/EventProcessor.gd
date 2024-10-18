@tool
extends Node
class_name EventProcessor

func _ready() -> void:
	if !Engine.is_editor_hint():
		print("Doing gods work!")
