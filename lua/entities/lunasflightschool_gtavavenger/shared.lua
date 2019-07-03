-- YOU CAN EDIT AND REUPLOAD THIS FILE. 
-- HOWEVER MAKE SURE TO RENAME THE FOLDER TO AVOID CONFLICTS

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript_vtol" )

ENT.PrintName = "Avenger"
ENT.Author = "NotAKid"
ENT.Information = ""
ENT.Category = "[LFS] GTAV"

ENT.Spawnable		= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/notakid/gtav/planes/avenger/avenger_main.mdl"


--[[
ENT.GibModels = {
	"models/notakid/gtav/planes/ls-22_starling/gibs/starling_main_broken.mdl",
	"models/notakid/gtav/planes/ls-22_starling/gibs/starling_prop_broken.mdl",
	"models/notakid/gtav/planes/ls-22_starling/gibs/starling_wingl_broken.mdl",
	"models/notakid/gtav/planes/ls-22_starling/gibs/starling_wingr_broken.mdl",
}
--]]

ENT.AITEAM = 1 -- 0 = FFA  1 = bad guys  2 = good guys

ENT.Mass = 4800
ENT.Inertia = Vector(250000,250000,250000)
ENT.Drag = 0.1

--ENT.HideDriver = true -- hide the driver?
ENT.SeatPos = Vector(297,28,-26)
ENT.SeatAng = Angle(0,-90,12)

ENT.WheelMass = 4000
ENT.WheelRadius = 10
ENT.WheelPos_L = Vector(-47.309,85.415,-92.005)
ENT.WheelPos_C = Vector(326.763,0,-92.005)
ENT.WheelPos_R = Vector(-47.309,-85.415,-92.005)


ENT.IdleRPM = 200 -- idle rpm. this can be used to tweak the minimum flight speed
ENT.MaxRPM = 2800 -- rpm at 100% throttle
ENT.LimitRPM = 3000 -- max rpm when holding throttle key
--ENT.RPMThrottleIncrement = 350 -- how fast the RPM should increase/decrease per second

ENT.RotorPos = Vector(393.131,0,-40.84) -- make sure you set these correctly or your plane will act wierd.
ENT.WingPos = Vector(70.767,0,72.545) -- make sure you set these correctly or your plane will act wierd. Excessive values can cause spazz.
ENT.ElevatorPos = Vector(-424.921,0,43.856) -- make sure you set these correctly or your plane will act wierd. Excessive values can cause spazz.
ENT.RudderPos = Vector(-412.235,0,124.348) -- make sure you set these correctly or your plane will act wierd. Excessive values can cause spazz.

ENT.MaxVelocity = 2000 -- max theoretical velocity at 0 degree climb
ENT.MaxPerfVelocity = 1600 -- speed in which the plane will have its maximum turning potential

ENT.MaxThrust = 2000

ENT.MaxTurnPitch = 800 -- max turning force in pitch, lower this value if you encounter spazz
ENT.MaxTurnYaw = 380 -- max turning force in yaw, lower this value if you encounter spazz
ENT.MaxTurnRoll = 240 -- max turning force in roll, lower this value if you encounter spazz

ENT.MaxHealth = 1200
--ENT.MaxShield = 200  -- uncomment this if you want to use deflector shields. Dont use excessive amounts because it regenerates.
--ONLY IF THIS STUUUUPID SHEILD DIDNT MAKE SPACE NOISES AND THE EFFECT Y U DO DIS i want the plane to be 650 health not a god and basiclly act the same as being "armored" with simfphys (i think that reduces/removes bullet damage? I WANT TO KEEP PHYSIC DAMAGE THO)
ENT.Stability = 0.4   -- if you uncomment this the plane will always be able to turn at maximum performance. This causes MaxPerfVelocity to get ignored
ENT.MaxStability = 0.4 -- lower this value if you encounter spazz. You can increase this up to 1 to aid turning performance at MaxPerfVelocity-speeds but be careful

ENT.VerticalTakeoff = true -- move vertically with landing gear out? REQUIRES ENT.Stability
 -- number is in % of throttle. Removes the landing gear dependency. Vtol mode will always be active when throttle is below this number. In this mode up movement is done with "Shift" key instead of W
ENT.MaxThrustVtol = 8000 -- amount of vertical thrust

ENT.MaxPrimaryAmmo = -1   -- set to a positive number if you want to use weapons. set to -1 if you dont
ENT.MaxSecondaryAmmo = -1 -- set to a positive number if you want to use weapons. set to -1 if you dont

ENT.MaxBombsAmmo = 8
ENT.BombPlane = true
function ENT:SetupDataTables()
	self:NetworkVar( "Entity",0, "Driver" )
	self:NetworkVar( "Entity",1, "DriverSeat" )
	self:NetworkVar( "Entity",2, "Gunner" )
	self:NetworkVar( "Entity",3, "GunnerSeat" )
	
	self:NetworkVar( "Bool",0, "Active" )
	self:NetworkVar( "Bool",1, "EngineActive" )
	self:NetworkVar( "Bool",2, "AI",	{ KeyName = "aicontrolled",	Edit = { type = "Boolean",	order = 1,	category = "AI"} } )
	self:NetworkVar( "Bool",4, "RotorDestroyed" )
	
	self:NetworkVar( "Bool",5, "OnGround" )
	self:NetworkVar( "Bool",6, "DoorOpen" )
	self:NetworkVar( "Bool",7, "CargoLock" )
	self:NetworkVar( "Bool",8, "GTAVAvenger" ) 

	
	self:NetworkVar( "Float",0, "LGear" )
	self:NetworkVar( "Float",1, "RGear" )
	self:NetworkVar( "Float",2, "RPM" )
	self:NetworkVar( "Float",3, "RotPitch" )
	self:NetworkVar( "Float",4, "RotYaw" )
	self:NetworkVar( "Float",5, "RotRoll" )
	self:NetworkVar( "Float",6, "HP", { KeyName = "health", Edit = { type = "Float", order = 2,min = 0, max = self.MaxHealth, category = "Misc"} } )
	self:NetworkVar( "Float",7, "Shield" )
	
	self:NetworkVar( "Float",8, "BayOpen" ) 
	self:NetworkVar( "Float",9, "BombsTime" ) 
	self:NetworkVar( "Float",10, "DoorOpenNum" ) 

	self:NetworkVar( "Int",0, "AmmoPrimary", { KeyName = "primaryammo", Edit = { type = "Int", order = 3,min = 0, max = self.MaxPrimaryAmmo, category = "Weapons"} } )
	self:NetworkVar( "Int",1, "AmmoSecondary", { KeyName = "secondaryammo", Edit = { type = "Int", order = 4,min = 0, max = self.MaxSecondaryAmmo, category = "Weapons"} } )
	self:NetworkVar( "Int",2, "AITEAM", { KeyName = "aiteam", Edit = { type = "Int", order = 2,min = 0, max = 2, category = "AI"} } )
	
	self:NetworkVar( "Int",3, "BombsAmmo", { KeyName = "ammobombs", Edit = { type = "Int", order = 6,min = 0, max = self.MaxBombsAmmo, category = "Weapons"} } )
	self:NetworkVar( "Int",4, "BombsType", { KeyName = "bombstype", Edit = { type = "Int", order = 5,min = 0, max = 4, category = "Weapons"} } )
	
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
end

sound.Add({
	name = "avengeralarm",
	channel = CHAN_STATIC,
	volume = 0.6, 
	level = 90,
	sound = "^plane_warning.wav"
})

sound.Add( {
	name = "GTAV_AVENGER_RPM1",
	channel = CHAN_STATIC,
	volume = 2.0,
	level = 100,
	sound = "^avenger_engine.wav"
} )

sound.Add( {
	name = "GTAV_AVENGER_RPM2",
	channel = CHAN_STATIC,
	volume = 2.0,
	level = 100,
	sound = "^avenger_heli_swtn2.wav"
} )

sound.Add( {
	name = "GTAV_AVENGER_PROP",
	channel = CHAN_STATIC,
	volume = 3.5,
	level = 100,
	sound = "^avenger_heli_prop.wav"
} )

sound.Add( {
	name = "GTAV_AVENGER_THRUST",
	channel = CHAN_STATIC,
	volume = 2.2,
	level = 100,
	sound = "^avenger_heli_jet.wav"
} )

sound.Add( {
	name = "GTAV_AVENGER_VTOL",
	channel = CHAN_STATIC,
	volume = 3.0,
	level = 100,
	sound = "^avenger_heli_jet.wav"
} )


sound.Add( {
	name = "GTAV_AVENGER_RPM3",
	channel = CHAN_STATIC,
	volume = 2.0,
	level = 100,
	sound = "^avenger_heli_swtn3.wav"
} )

sound.Add( {
	name = "GTAV_AVENGER_RPM4",
	channel = CHAN_STATIC,
	volume = 2.0,
	level = 100,
	sound = "^avenger_heli_swtn4.wav"
} )

sound.Add( {
	name = "GTAV_JET_DIST",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 100,
	sound = "^LAZER_DISTANT_LOOP.wav"
} )

function ENT:GetMaxBombsAmmo()
	return self.MaxBombsAmmo
end

function ENT:GetBombSelection()
	local BombsType = self:GetBombsType()
	nak_overpowered = GetConVar( "nak_overpowered_bombs" )
	
	if nak_overpowered:GetInt() == 1 then -- Overpowered Bombs List
		if BombsType == 0 then
			return "gb_bomb_1000gp"
		elseif BombsType == 1 then
			return "gb_bomb_mk77"
		elseif BombsType == 2 then
			return "gb_bomb_500gp"
		elseif BombsType == 3 then
			return "gb_bomb_cbu"
		end
	else
		if BombsType == 0 then -- Normal Bomb List
			return "gb_bomb_250gp"
		elseif BombsType == 1 then
			return "gb_bomb_fab250"
		elseif BombsType == 2 then
			return "gb_bomb_sc500"
		elseif BombsType == 3 then
			return "gb_bomb_cbu"
		end
	end
end

function ENT:GetBombSelectionTime()
	local BombsType = self:GetBombsType()
	nak_overpowered = GetConVar( "nak_overpowered_bombs" )
	
	if nak_overpowered:GetInt() == 1 then -- Overpowered Bombs List Reload Time
		if BombsType == 0 then
			return 15
		elseif BombsType == 1 then
			return 15
		elseif BombsType == 2 then
			return 8
		elseif BombsType == 3 then
			return 8
		end
	else
		if BombsType == 0 then -- Normal Bomb List Reload Time
			return 2.5
		elseif BombsType == 1 then
			return 2.5
		elseif BombsType == 2 then
			return 4
		elseif BombsType == 3 then
			return 8
		end
	end
end