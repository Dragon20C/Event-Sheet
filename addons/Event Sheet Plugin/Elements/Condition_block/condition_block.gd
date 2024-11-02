@tool
extends Button
class_name ConditionBlock

@export var condition : Event ## Replace with a custom resource class
@export var event_block : EventBlock


func _on_pressed() -> void:
	event_block.condition_options.emit(self)
