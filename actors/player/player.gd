extends CharacterBody3D

# This := prevents any changes to said floats (numbers with decimals)
# var norm_speed : float = 3.0 is equivalent to what is below
# @export allows changes in the "3D view" 
@export var norm_speed := 3.0
@export var sprint_speed := 5.0
@export var jump_velocity := 4.0
@export var gravity_speed = 0.2
@export var mouse_sensitivity = 0.005
@export var walking_energy_change_per_1m := -0.05
@export var walking_step_audio_interval := 0.6
@export var sprint_audio_interval := 0.3

#Creating code for the Head 
#Drag Head drop by holding ctrl

var is_sprinting := false
var is_grounded := true

@onready var head: Node3D = $Head
@onready var interaction_ray_cast: RayCast3D = $Head/InteractionRayCast
@onready var equippable_item_holder: Node3D = %EquippableItemHolder
@onready var foot_step_audio_timer: Timer = $FootStepAudioTimer

func _enter_tree() -> void:
	EventSystem.PLA_freeze_player.connect(set_freeze.bind(true))
	EventSystem.PLA_unfreeze_player.connect(set_freeze.bind(false))

func set_freeze(freeze : bool) -> void:
	set_process(!freeze)
	set_physics_process(!freeze)
	set_process_input(!freeze)
	set_process_unhandled_key_input(!freeze)


func _ready() -> void:
	EventSystem.HUD_show_hud.emit()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _exit_tree() -> void:
	EventSystem.HUD_hide_hud.emit()


func _process(delta: float) -> void:
	interaction_ray_cast.check_interaction()


#Built-in function the activates 1 fps
func _physics_process(delta: float) -> void:
	move()
	check_walking_energy_change(delta) 
	
	if Input.is_action_just_pressed("use_item"):
		equippable_item_holder.try_to_use_item()


#holding ctrl and left clicking on a function will give you an explanation 
#of what the function does
#To close the manual press the middle mouse button
func move() -> void:
	var is_sprinting : bool
	
	if is_on_floor():
		is_sprinting = Input.is_action_pressed('sprint')
		
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
		
		if velocity != Vector3.ZERO and foot_step_audio_timer.is_stopped():
			EventSystem.SFX_play_dynamic_sfx.emit(SFXConfig.Keys.FootStep, global_position, 0.3)
			foot_step_audio_timer.start(walking_step_audio_interval if not is_sprinting else sprint_audio_interval )
		
		if not is_grounded:
			is_grounded = true
			EventSystem.SFX_play_dynamic_sfx.emit(SFXConfig.Keys.Jump, global_position)
		
	else:
		velocity.y -= gravity_speed
		
		if is_grounded:
			is_grounded = false
		
	###################################
	#var speed: float
	#
	#if is_sprinting:
		#speed = sprint_speed
	#else:
		#speed = norm_speed
	###################################
	#Or you type this instead
	
	var speed = norm_speed if not is_sprinting else sprint_speed
	
	var input_dir := Input.get_vector('move_left','move_right',"move_forward","move_backward") 
	var direction := transform.basis * Vector3(input_dir.x, 0,input_dir.y)
	
	velocity.z = direction.z * speed
	velocity.x = direction.x * speed
	
	move_and_slide()
	

func check_walking_energy_change(delta : float) -> void:
	if velocity.x or velocity.z:
		EventSystem.PLA_change_energy.emit(
			delta * 
			walking_energy_change_per_1m * 
			Vector2(velocity.z, velocity.x).length()
		) 


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)

func look_around(relative : Vector2) -> void:
	rotate_y(-relative.x * mouse_sensitivity)
	head.rotate_x(-relative.y * mouse_sensitivity)
	head.rotation_degrees.x = clampf(head.rotation_degrees.x,-90,90)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.PauseMenu)
	
	elif event.is_action_pressed('open_crafting_menu'):
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.CraftingMenu)
	
	elif event.is_action_pressed("item_hotkey"):
		EventSystem.EQU_hotkey_pressed.emit(int(event.as_text()))

