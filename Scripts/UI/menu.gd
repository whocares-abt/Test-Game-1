extends VBoxContainer

@onready var menu_item = load("res://Scenes/UI/menu_item.tscn")
var menu_item_size = Vector2(250, 40)

signal menu_item_chosen(item)

func update_item_size(new_item_size):
	self.menu_item_size = new_item_size

func update_size(new_size):
	self.size = new_size

func change_alignment(new_alignment):
	self.alignment = new_alignment

func create_menu(items : Variant, should_grab_focus : bool) -> void:
	delete_all_children()

	for item in items:
		var item_button = menu_item.instantiate()
		self.add_child(item_button)
		
		item_button.update_item(item)
		item_button.update_size(menu_item_size)

		if (item_button.has_signal("menu_item_chosen")):
			var err = item_button.menu_item_chosen.connect(item_chosen.bind())
			if (err != OK):
				printerr("Unable to connect. Error: ", error_string(err))
		else:
			printerr("No signal to notify menu item picked")

	if (should_grab_focus):
		self.grab_focus()

func remove_menu():
	delete_all_children()

func delete_all_children():
	for child in self.get_children():
		self.remove_child(child)
		child.queue_free()

func item_chosen(item):
	menu_item_chosen.emit(item)
