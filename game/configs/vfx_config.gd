class_name VFXConfig

enum Keys {
	HitParticlesBlood,
	HitParticlesStone,
	HitParticlesWood
}


const FILE_PATH := {
	Keys.HitParticlesBlood : "res://particles/hit_particles_blood.tscn",
	Keys.HitParticlesStone : "res://particles/hit_particles_stone.tscn",
	Keys.HitParticlesWood : "res://particles/hit_particles_wood.tscn"
}
static func get_vfx(keys:Keys) -> PackedScene:
	return load(FILE_PATH.get(keys))
