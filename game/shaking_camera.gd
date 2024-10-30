extends Camera3D
class_name ShakingCamera

@export var noise_speed := 1.0
@export var noise_multiplier := 0.25

var noise := FastNoiseLite.new()

func _ready() -> void:
	noise.seed = randi() 
	noise.frequency = noise_speed * 0.00001
	

func _process(delta: float) -> void:
	rotation.x = noise.get_noise_1d(Time.get_ticks_msec()) * noise_multiplier
	# The + 10000 means 10000 miliseconds =  10 sec this cause the 
	#shake to be on the y and x to not be the same which is what we want.
	rotation.y = noise.get_noise_1d(Time.get_ticks_msec()+ 10000) * noise_multiplier
