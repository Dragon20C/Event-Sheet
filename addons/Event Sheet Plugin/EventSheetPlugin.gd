@tool
extends EditorPlugin


const _EventSheet = preload("res://addons/Event Sheet Plugin/Elements/Event_sheet/Event_sheet.tscn")
var event_sheet : Control


func _enter_tree():
	add_autoload_singleton("EventProcessor", "res://addons/Event Sheet Plugin/EventProcessor.gd")
	
	event_sheet = _EventSheet.instantiate()
	# Add the main panel to the editor's main viewport.
	EditorInterface.get_editor_main_screen().add_child(event_sheet)
	# Hide the main panel. Very much required.
	_make_visible(false)


func _exit_tree():
	remove_autoload_singleton("EventProcessor")
	if event_sheet:
		event_sheet.queue_free()

func _has_main_screen():
	return true

func _make_visible(visible):
	if event_sheet:
		event_sheet.visible = visible


func _get_plugin_name():
	return "Event Window"


func _get_plugin_icon():
	# Must return some kind of Texture for the icon.
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
