@tool
extends MarginContainer
class_name EventSheet

@onready var blank_event_blk : PackedScene = preload("res://addons/Event Sheet Plugin/Elements/Event_block/event_block.tscn")

@export var event_block_container : VBoxContainer
@export var popup_menu : PopupMenu

var popup_data : Dictionary = {
	"general": ["Add Blank Event"],
	"event_block": ["Add Event", "Add Action", "", "Delete Blank Event"],
	"event": ["Edit Event", "Add Event", "", "Delete Event"],
	"action": ["Edit Action", "Add Action", "", "Delete Action"]
}

var current_popup : String = "general"

## For modifying blocks
var event_block : EventBlock
var condition_block : ConditionBlock
var action_block : ActionBlock

var event_blocks : Array[EventBlock]

func handle_popup(popup_type : String) -> void:
	current_popup = popup_type
	if not popup_data.has(popup_type): return
	
	var mouse_pos = Vector2i(get_viewport().get_mouse_position()) + get_window().position
	
	popup_menu.clear()
	
	for item in popup_data[popup_type]:
		if item == "":
			popup_menu.add_separator()
		else:
			popup_menu.add_item(item)
			
	popup_menu.set_size(Vector2(0, 0))
	popup_menu.set_position(mouse_pos)
	popup_menu.show()

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			handle_popup("general")
			print("Event sheet pressed!")


func _on_popup_menu_index_pressed(index: int) -> void:
	
	match current_popup:
		"general":
			match index:
				0:
					add_blank_event_blk()
		"event_block":
			match index:
				0:
					add_event()
				1:
					add_action()
				3:
					delete_event_blk()
		"event":
			print("Yay Event!")
			match index:
				0:
					edit_event()
				1:
					add_event()
				3:
					delete_event()
		"action":
			match index:
				0:
					edit_action()
				1:
					add_action()
				3:
					delete_action()

func delete_event() -> void:
	condition_block.queue_free()
	print("Deleted the event")
	
func delete_action() -> void:
	action_block.queue_free()
	print("Deleted the action")

func edit_event() -> void:
	#condition_block
	print("Edited the event!")

func edit_action() -> void:
	#action_block
	print("edited the action!")

func add_event() -> void:
	event_block.add_condition_block()
	print("Adding event!")
	
func add_action() -> void:
	print("Adding action!")
	event_block.add_action_block()

func add_blank_event_blk() -> void:
	var blank_block : EventBlock = blank_event_blk.instantiate()
	blank_block.event_sheet = self
	blank_block.event_block_options.connect(handle_event_block_signal)
	event_block_container.add_child(blank_block)

func delete_event_blk() -> void:
	print("Deleted!")
	event_block.queue_free()
	event_block = null

func handle_event_block_signal(_event_block : EventBlock) -> void:
	event_block = _event_block
	handle_popup("event_block")
