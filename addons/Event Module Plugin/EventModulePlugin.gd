@tool
extends EditorPlugin


const EventWindow = preload("res://addons/Event Module Plugin/GUI/EventWindow.tscn")
var event_window : Control


func _enter_tree():
	event_window = EventWindow.instantiate()
	# Add the main panel to the editor's main viewport.
	EditorInterface.get_editor_main_screen().add_child(event_window)
	# Hide the main panel. Very much required.
	_make_visible(false)


func _exit_tree():
	if event_window:
		event_window.queue_free()

func _has_main_screen():
	return true

func _make_visible(visible):
	if event_window:
		event_window.visible = visible


func _get_plugin_name():
	return "Event Window"


func _get_plugin_icon():
	# Must return some kind of Texture for the icon.
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
