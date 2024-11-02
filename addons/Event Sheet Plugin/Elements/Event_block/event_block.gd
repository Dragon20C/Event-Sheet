@tool
extends MarginContainer
class_name EventBlock

signal event_block_options(event_block : EventBlock)
signal condition_options(condition : ConditionBlock)
signal action_options(action : ActionBlock)

@export var condition_blk_container :VBoxContainer
@export var action_blk_container : VBoxContainer
@export var add_action_button : Button

## Store the scenes for an action and event
## action_blk is what activates
## while a condition block is what needs to be true to activate the actions
@onready var blank_action_blk : PackedScene = preload("res://addons/Event Sheet Plugin/Elements/Action_block/Action_block.tscn")
@onready var blank_condition_blk : PackedScene = preload("res://addons/Event Sheet Plugin/Elements/Condition_block/Condition_block.tscn")

## Events hold the conditions that runs the actions
## E.G If ready function called, then all actions play

@export var events : Array
@export var actions : Array

var event_sheet : EventSheet

func _ready() -> void:
	condition_options.connect(handle_condition_popup)
	action_options.connect(handle_action_popup)

func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			event_block_options.emit(self)
			print("You just pressed this event block")


func _on_add_action_pressed() -> void:
	add_action_block()

func add_condition_block() -> void:
	var blank_condition : ConditionBlock = blank_condition_blk.instantiate()
	blank_condition.event_block = self
	condition_blk_container.add_child(blank_condition)

# in the future this would also need to add the action
func add_action_block() -> void:
	var blank_action : ActionBlock = blank_action_blk.instantiate()
	blank_action.event_block = self
	action_blk_container.add_child(blank_action)
	action_blk_container.move_child(add_action_button,-1)

func handle_action_popup(action : ActionBlock) -> void:
	event_sheet.action_block = action
	event_sheet.handle_popup("action")

func handle_condition_popup(condition : ConditionBlock) -> void:
	event_sheet.condition_block = condition
	event_sheet.handle_popup("event")
