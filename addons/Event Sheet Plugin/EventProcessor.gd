@tool
extends Node
# EventProcessor

func _ready() -> void:
	if !Engine.is_editor_hint():
		print("event processer ready!")
