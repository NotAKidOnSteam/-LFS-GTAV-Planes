--DO NOT EDIT OR REUPLOAD THIS FILE

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript" )

ENT.PrintName = "Starling"
ENT.Author = "NotAKid"
ENT.Information = ""
ENT.Category = "[LFS] GTAV"

ENT.Spawnable		= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/notakid/gtav/planes/ls-22_starling/starling_main.mdl"



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

ENT.SeatPos = Vector(22,0,85.8)
ENT.SeatAng = Angle(0,-90,16)

ENT.WheelMass = 500
ENT.WheelRadius = 10
ENT.WheelPos_L = Vector(18.5,8,59.2)
ENT.WheelPos_C = Vector(-130,0,73)
ENT.WheelPos_R = Vector(18.5,-8,59.2)


ENT.IdleRPM = 80
ENT.MaxRPM = 1500
ENT.LimitRPM = 2000

ENT.RotorPos = Vector(184.247,0,66.909)
ENT.WingPos = Vector(21.437,0,48.999)
ENT.ElevatorPos = Vector(-200.309,0,91.064)
ENT.RudderPos = Vector(-215.205,0,129.616)

ENT.MaxVelocity = 2100

ENT.MaxThrust = 2200

ENT.MaxTurnPitch = 300
ENT.MaxTurnYaw = 450
ENT.MaxTurnRoll = 200

ENT.MaxPerfVelocity = 2400

ENT.MaxHealth = 400

ENT.MaxPrimaryAmmo = 1200
ENT.MaxSecondaryAmmo = 6
ENT.MaxBombsAmmo = 8


ENT.MISSILEMDL = "models/notakid/gtav/planes/ls-22_starling/starling_missle.mdl"

ENT.MISSILES = {

	[1] = { Vector(-11,66.74,83.3), Vector(-11,-66.74,83.3) },

	[2] = { Vector(-11,82.8,83.3), Vector(-11,-82.8,83.3) },

	[3] = { Vector(-11,74.77,83.3), Vector(-11,-74.77,83.3)  },

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

function ENT:SetupDataTables()

	self:NetworkVar( "Entity",0, "Driver" )

	self:NetworkVar( "Entity",1, "DriverSeat" )

	self:NetworkVar( "Entity",2, "Gunner" )

	self:NetworkVar( "Entity",3, "GunnerSeat" )

	

	self:NetworkVar( "Bool",0, "Active" )

	self:NetworkVar( "Bool",1, "EngineActive" )

	self:NetworkVar( "Bool",2, "AI",	{ KeyName = "aicontrolled",	Edit = { type = "Boolean",	order = 1,	category = "AI"} } )

	self:NetworkVar( "Bool",4, "RotorDestroyed" )

	

	self:NetworkVar( "Int",2, "AITEAM", { KeyName = "aiteam", Edit = { type = "Int", order = 2,min = 0, max = 2, category = "AI"} } )

	

	self:NetworkVar( "Float",0, "LGear" )

	self:NetworkVar( "Float",1, "RGear" )

	self:NetworkVar( "Float",2, "RPM" )

	self:NetworkVar( "Float",3, "RotPitch" )

	self:NetworkVar( "Float",4, "RotYaw" )

	self:NetworkVar( "Float",5, "RotRoll" )

	self:NetworkVar( "Float",6, "HP", { KeyName = "health", Edit = { type = "Float", order = 2,min = 0, max = self.MaxHealth, category = "Misc"} } )

	

	self:NetworkVar( "Float",7, "Shield" )

	

	self:NetworkVar( "Int",0, "AmmoPrimary", { KeyName = "primaryammo", Edit = { type = "Int", order = 3,min = 0, max = self.MaxPrimaryAmmo, category = "Weapons"} } )
	self:NetworkVar( "Int",1, "AmmoSecondary", { KeyName = "secondaryammo", Edit = { type = "Int", order = 4,min = 0, max = self.MaxSecondaryAmmo, category = "Weapons"} } )
	
	--100% not taken from LFSPlanes base :P BombsAmmo is the name! THE GAME AUTO MAKES Get(networkvar name) and Set(networkvar name)!!!!! dont make these yourself like me and get pissed that it doesnt work!
	self:NetworkVar( "Int",3, "BombType", { KeyName = "bombtype", Edit = { type = "Int", order = 5,min = 0, max = 4, category = "Weapons"} } )
	self:NetworkVar( "Int",4, "BombsAmmo", { KeyName = "ammobombs", Edit = { type = "Int", order = 6,min = 0, max = self.MaxBombsAmmo, category = "Weapons"} } )
	if SERVER then
		self:NetworkVarNotify( "AI", self.OnToggleAI )
		self:SetAITEAM( self.AITEAM )
		self:SetHP( self.MaxHealth )
		self:SetShield( self.MaxShield )
		self:OnReloadWeapon()
	end
	self:AddDataTables()
end


function ENT:AddDataTables()
	--add this bit just because i said so idk if it actually makes it work but dont test it or else it might error and make you restart the game to clear the error completly even after undoing
end


ENT.BombPlane = true -- this bit is looked for in line 70 of nak_gtav_planes.lua. what makes my custom hud paint not show on normal lfs planes other than ones with true!


--the networkvar doesnt make MaxBombsAmmo into GetMaxBombsAmmo as it is not in there. I mean, u could but it would be stupid :P
--You add the MAX ones manually. because it has get in front DOESNT mean it needs to, you could recode ONLY THIS ONE to be anything!
function ENT:GetMaxBombsAmmo()
	return self.MaxBombsAmmo
end

-- I am commenting all this for the day I forget how to do this, and if someone else wants to look through my code :)
-- sorry I cant code well :P
-- I try my best and sometimes succeed..