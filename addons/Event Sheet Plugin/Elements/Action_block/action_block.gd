@tool
extends Button
class_name ActionBlock

@export var action : Action
@export var event_block : EventBlock


func _on_pressed() -> void:
	print("Action block pressed")
	event_block.action_options.emit(self)
