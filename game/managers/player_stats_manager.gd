extends Node

const MAX_ENERGY = 100.0
const MAX_HEALTH = 100.0


var current_energy := MAX_ENERGY
var current_health := MAX_HEALTH

func _enter_tree() -> void:
	EventSystem.PLA_change_energy.connect(change_energy)
	EventSystem.PLA_change_health.connect(change_health)
	
func change_energy(amount : float) -> void:
	current_energy += amount
	EventSystem.PLA_updated_energy.emit(MAX_ENERGY, current_energy)
	
	if current_energy < 0:
		change_health(current_energy)
	
	current_energy = clampf(current_energy,0,MAX_ENERGY)
	
	EventSystem.PLA_updated_energy.emit(MAX_ENERGY, current_energy)

func change_health(hp_amount : float) -> void:
	current_health = clampf(current_health + hp_amount, 0 , MAX_HEALTH)
	EventSystem.PLA_updated_health.emit(MAX_HEALTH, current_health)
	
