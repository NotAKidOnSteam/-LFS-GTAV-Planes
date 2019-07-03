--DO NOT EDIT OR REUPLOAD THIS FILE

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript" )

ENT.PrintName = "Lazer"
ENT.Author = "NotAKid"
ENT.Information = ""
ENT.Category = "[LFS] GTAV"

ENT.Spawnable		= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/notakid/gtav/planes/lazer/lazer_main.mdl"



ENT.GibModels = {
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_1.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_2.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_3.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_4.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_5.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_6.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_7.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_break_extra_8.mdl",
	"models/notakid/gtav/planes/lazer/gibs/lazer_main_broken.mdl",
}

ENT.AITEAM = 1

ENT.Mass = 2800
ENT.Inertia = Vector(250000,250000,250000)
ENT.Drag = 0.1

ENT.SeatPos = Vector(165,0,100)
ENT.SeatAng = Angle(0,-90,25)

ENT.WheelMass = 500
ENT.WheelRadius = 10
ENT.WheelPos_L = Vector(-31,50,47)
ENT.WheelPos_R = Vector(-31,-50,47)
ENT.WheelPos_C = Vector(120,0,44)


ENT.IdleRPM = 60
ENT.MaxRPM = 1700
ENT.LimitRPM = 2100

ENT.RotorPos = Vector(184.247,0,66.909)
ENT.WingPos = Vector(21.437,0,48.999)
ENT.ElevatorPos = Vector(-200.309,0,91.064)
ENT.RudderPos = Vector(-215.205,0,129.616)

ENT.MaxVelocity = 3100

ENT.MaxThrust = 2500

ENT.MaxTurnPitch = 300
ENT.MaxTurnYaw = 450
ENT.MaxTurnRoll = 200

ENT.MaxPerfVelocity = 2400

ENT.MaxHealth = 400

ENT.MaxPrimaryAmmo = 1200
ENT.MaxSecondaryAmmo = 6


ENT.MISSILEMDL = "models/notakid/gtav/planes/lazer/lazer_missle.mdl"

ENT.MISSILES = {

	[1] = { Vector(-23.227,157.092,82.297), Vector(-23.227,-157.092,82.297) },

	[2] = { Vector(-8.607,119.368,81.151), Vector(-8.607,-119.368,81.151) },

	[3] = { Vector(-44.304,190.069,100), Vector(-44.304,-190.069,100)  },

}


sound.Add( {
	name = "GTAV_JET_RPM1",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^JET_ENGINE_04A.wav"
} )

sound.Add( {
	name = "GTAV_JET_RPM2",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^JET_ENGINE_04A2.wav"
} )

sound.Add( {
	name = "GTAV_JET_AIRNOISE",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^NOISE_AIR.wav"
} )

sound.Add( {
	name = "GTAV_JET_THRUST",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^THRUST.wav"
} )


sound.Add( {
	name = "GTAV_JET_RPM3",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^JET_ENGINE_04A3.wav"
} )

sound.Add( {
	name = "GTAV_JET_RPM4",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^JET_ENGINE_04A4.wav"
} )

sound.Add( {
	name = "GTAV_JET_DIST",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^LAZER_DISTANT_LOOP.wav"
} )

sound.Add({
	name = "lazeralarm",
	channel = CHAN_STATIC,
	volume = 0.6, 
	level = 90,
	sound = "^plane_warning.wav"
})
