class_name SFXConfig

enum Keys {
	UIClick,
	ItemPickUp,
	Craft,
	Build,
	WeaponSwoosh,
	Eating
}

const FILE_PATH := {
	Keys.UIClick : "res://audio/sfx/ui_click.wav",
	Keys.ItemPickUp : "res://audio/sfx/item_pickup.wav",
	Keys.Craft : "res://audio/sfx/craft.wav",
	Keys.Build : "res://audio/sfx/build.wav",
	Keys.WeaponSwoosh : "res://audio/sfx/weapon_swoosh.wav",
	Keys.Eating : "res://audio/sfx/eat.wav"
}


static func get_audio_stream(keys:Keys) -> AudioStream:
	return load(FILE_PATH.get(keys))
