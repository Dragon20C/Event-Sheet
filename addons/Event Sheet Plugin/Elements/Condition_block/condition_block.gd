@tool
extends Button
class_name ConditionBlock

@export var condition : int ## Replace with a custom resource class


func _on_pressed() -> void:
	print("Condition block pressed!")
