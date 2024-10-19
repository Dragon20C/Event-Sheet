@tool
extends Panel
class_name EventSheet

@onready var blank_panel : PackedScene = preload("res://addons/Event Sheet Plugin/GUI/EventBar/EventBar.tscn")
@export_subgroup("Nodes")
@export var event_container : VBoxContainer
var current_menu : String = "General"

var current_panel : EventPanel
var current_event
var current_action

var is_mouse_focused : bool = false

var popup_menus: Dictionary = {
	"general": ["Add Blank Event"],
	"blank_body": ["Add Event", "Add Action", "", "Delete Blank Event"],
	"event": ["Edit Event", "Add Event", "", "Delete Event"],
	"action": ["Edit Action", "Add Action", "", "Delete Action"]
}

@export_subgroup("PopUpNodes")
@export var popup_menu : PopupMenu

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click and is_mouse_focused:
			pass
			#show_add_window("event")
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and is_mouse_focused:
			show_popup_menu()

func _on_popup_menu_index_pressed(index: int) -> void:
	match current_menu:
		"general":
			match index:
				0:
					## Add a blank panel to the window
					var blank_event : EventPanel= blank_panel.instantiate()
					blank_event.selected.connect(handle_panel_focus)
					event_container.add_child(blank_event)
					current_event = "blank_body"
					
	#print("Index : %s" % index)

func show_popup_menu(menu: String = "general"):
	current_menu = menu
	var mouse_pos = Vector2i(get_viewport().get_mouse_position()) + get_window().position
	popup_menu.clear()
	for item in popup_menus[menu]:
		if item == "": popup_menu.add_separator()
		else: popup_menu.add_item(item)
	popup_menu.set_size(Vector2(0, 0))
	popup_menu.set_position(mouse_pos)
	popup_menu.show()

func handle_panel_focus(panel : EventPanel) -> void:
	print("Panel has focused!")
	current_panel = panel

func _on_mouse_entered() -> void:
	is_mouse_focused = true
	
func _on_mouse_exited() -> void:
	is_mouse_focused = false
