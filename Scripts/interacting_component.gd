extends Node2D

var curr_interactables = []
@export var can_interact = true

# Interacting component interacts with nearest interactible
func interact_with_object():
	
	if curr_interactables and can_interact:
		curr_interactables.sort_custom(_interact_distance_sort)
		
		if (curr_interactables[0].is_interactable):
			can_interact = false
			await curr_interactables[0].interact.call()
			can_interact = true

# Sorts objects based on interactability and then distance
func _interact_distance_sort(area1 : Area2D, area2 : Area2D):
	
	if (area1.is_interactable and not area2.is_interactable):
		return false
	if (area2.is_interactable and not area1.is_interactable):
		return true
		
		
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist

func _on_interaction_area_area_entered(area: Area2D) -> void:
	curr_interactables.push_back(area)

func _on_interaction_area_area_exited(area: Area2D) -> void:
	curr_interactables.erase(area)
