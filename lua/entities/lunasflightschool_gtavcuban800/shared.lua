--DO NOT EDIT OR REUPLOAD THIS FILE

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript" )

ENT.PrintName = "Cuban 800"
ENT.Author = "NotAKid"
ENT.Information = ""
ENT.Category = "[LFS] GTAV"

ENT.Spawnable		= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/notakid/gtav/planes/cuban800/cuban800_main.mdl"



ENT.GibModels = {
	"models/notakid/gtav/planes/cuban800/gibs/cuban800_main_broken.mdl",
	"models/notakid/gtav/planes/cuban800/gibs/cuban800_tail_broken.mdl",
	"models/notakid/gtav/planes/cuban800/gibs/cuban800_prop1_broken.mdl",
	"models/notakid/gtav/planes/cuban800/gibs/cuban800_prop2_broken.mdl",
	"models/notakid/gtav/planes/cuban800/gibs/cuban800_wingl_broken.mdl",
	"models/notakid/gtav/planes/cuban800/gibs/cuban800_wingr_broken.mdl",
}

ENT.AITEAM = 2

ENT.Mass = 2800
ENT.Inertia = Vector(250000,250000,250000)
ENT.Drag = 0.2

ENT.SeatPos = Vector(45,11,61)
ENT.SeatAng = Angle(0,-90,10)

ENT.WheelMass = 500
ENT.WheelRadius = 10
ENT.WheelPos_L = Vector(32,80.499,25)
ENT.WheelPos_R = Vector(32,-80.499,25)
ENT.WheelPos_C = Vector(145,0,25)

ENT.IdleRPM = 180
ENT.MaxRPM = 1400
ENT.LimitRPM = 1600

ENT.RotorPos = Vector(184.247,0,66.909)
ENT.WingPos = Vector(21.437,0,48.999)
ENT.ElevatorPos = Vector(-200.309,0,91.064)
ENT.RudderPos = Vector(-215.205,0,129.616)

ENT.MaxVelocity = 1400

ENT.MaxThrust = 780

ENT.MaxTurnPitch = 300
ENT.MaxTurnYaw = 450
ENT.MaxTurnRoll = 200

ENT.MaxPerfVelocity = 2400

ENT.MaxHealth = 400

ENT.MaxPrimaryAmmo = 25
ENT.MaxSecondaryAmmo = 4

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

sound.Add({
	name = "cuban800alarm",
	channel = CHAN_STATIC,
	volume = 0.6, 
	level = 90,
	sound = "^plane_warning.wav"
})

