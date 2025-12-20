extends Button

signal menu_item_chosen(item_name)

func update_item(new_item):
	self.text = new_item

func update_size(new_size):
	self.size = new_size

func _on_pressed() -> void:
	menu_item_chosen.emit(self.text)
