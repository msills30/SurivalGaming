class_name SFXConfig

enum Keys {
	UIClick,
	ItemPickUp,
	Craft,
	Build,
	WeaponSwoosh,
	Eating,
	TreeHit,
	BoulderHit,
	CowHurt,
	CowAttack,
	WolfHurt,
	WolfAttack,
	FootStep,
	Jump,
	GetInTent
}

const FILE_PATH := {
	Keys.UIClick : "res://audio/sfx/ui_click.wav",
	Keys.ItemPickUp : "res://audio/sfx/item_pickup.wav",
	Keys.Craft : "res://audio/sfx/craft.wav",
	Keys.Build : "res://audio/sfx/build.wav",
	Keys.WeaponSwoosh : "res://audio/sfx/weapon_swoosh.wav",
	Keys.Eating : "res://audio/sfx/eat.wav",
	Keys.TreeHit : "res://audio/sfx/tree_hit.wav",
	Keys.BoulderHit : "res://audio/sfx/boulder_hit.wav",
	Keys.CowHurt : "res://audio/sfx/cow_hurt.wav",
	Keys.CowAttack : "res://audio/sfx/cow_attack.wav",
	Keys.WolfHurt : "res://audio/sfx/wolf_hurt.wav",
	Keys.WolfAttack : "res://audio/sfx/wolf_attack.wav",
	Keys.Jump : "res://audio/sfx/jump_land.wav",
	Keys.FootStep : "res://audio/sfx/footstep.wav",
	Keys.GetInTent : "res://audio/sfx/go_in_tent.wav"
}


static func get_audio_stream(keys:Keys) -> AudioStream:
	return load(FILE_PATH.get(keys))
