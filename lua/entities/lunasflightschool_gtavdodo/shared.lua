--DO NOT EDIT OR REUPLOAD THIS FILE

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript" )

ENT.PrintName = "Dodo"
ENT.Author = "NotAKid"
ENT.Information = ""
ENT.Category = "[LFS] GTAV"

ENT.Spawnable		= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/notakid/gtav/planes/dodo/dodo_main.mdl"



ENT.GibModels = {
	"models/notakid/gtav/planes/dodo/gibs/dodo_main_broken.mdl",
	"models/notakid/gtav/planes/dodo/gibs/dodo_wingl_broken.mdl",
	"models/notakid/gtav/planes/dodo/gibs/dodo_wingr_broken.mdl",
}

ENT.AITEAM = 2

ENT.Mass = 2700
ENT.Inertia = Vector(250000,250000,250000)
ENT.Drag = 0.2

ENT.SeatPos = Vector(0,11.5,70)
ENT.SeatAng = Angle(0,-90,12)

ENT.WheelMass = 400
ENT.WheelRadius = 7
ENT.WheelPos_C = Vector(112.488,55.562,8)
ENT.WheelPos_E = Vector(112.488,-55.562,8)
ENT.WheelPos_L = Vector(-43.661,-55.562,7.2)
ENT.WheelPos_R = Vector(-43.661,55.562,7.2)

ENT.IdleRPM = 300
ENT.MaxRPM = 1200
ENT.LimitRPM = 1300

ENT.RotorPos = Vector(184.247,0,66.909)
ENT.WingPos = Vector(21.437,0,48.999)
ENT.ElevatorPos = Vector(-200.309,0,91.064)
ENT.RudderPos = Vector(-215.205,0,129.616)

ENT.MaxVelocity = 2135

ENT.MaxThrust = 800

ENT.MaxTurnPitch = 300
ENT.MaxTurnYaw = 450
ENT.MaxTurnRoll = 200

ENT.MaxPerfVelocity = 2800

ENT.MaxHealth = 310

ENT.MaxPrimaryAmmo = -1
ENT.MaxSecondaryAmmo = -1


sound.Add( {
	name = "LFS_SPITFIRE_RPM1",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^lfs/spitfire/rpm_1.wav"
} )

sound.Add( {
	name = "LFS_SPITFIRE_RPM2",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^lfs/spitfire/rpm_2.wav"
} )

sound.Add( {
	name = "LFS_SPITFIRE_RPM3",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^lfs/spitfire/rpm_3.wav"
} )

sound.Add( {
	name = "LFS_SPITFIRE_RPM4",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^lfs/spitfire/rpm_4.wav"
} )

sound.Add( {
	name = "LFS_SPITFIRE_DIST",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^lfs/spitfire/dist.wav"
} )
