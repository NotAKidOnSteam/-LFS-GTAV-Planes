--DO NOT EDIT OR REUPLOAD THIS FILE

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")


function ENT:SpawnFunction( ply, tr, ClassName )

	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal * 120 + Vector(0,0,-120) )
	ent:Spawn()
	ent:Activate()

	return ent
end






function ENT:RunOnSpawn()
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	if nak_color_planes_when_spawned:GetBool() == true then
		local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	
	self:AddPassengerSeat( Vector(38,-11,61), Angle(0,-90,10) )
	self:AddPassengerSeat( Vector(-33,11,61), Angle(0,-90,10) )
	self:AddPassengerSeat( Vector(-33,-11,61), Angle(0,-90,10) )
	self:SetNWBool("carkeysSupported", true)
	self:SetNWBool("carkeysCustomAlarm", true)
	self:SetNWString("carkeysCAlarmSound", "velumalarm")
end

function ENT:PrimaryAttack()

end

function ENT:CreateAI()
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	if nak_color_planes_when_spawned:GetBool() == false then
		local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end
end

function ENT:RemoveAI()
end

function ENT:SecondaryAttack()
end



function ENT:OnEngineStarted()
	self:EmitSound( "lfs/spitfire/start.wav" )
end

function ENT:OnEngineStopped()
	self:EmitSound( "lfs/spitfire/stop.wav" )
end




function ENT:OnLandingGearToggled( bOn )
	self:EmitSound( "lfs/bf109/gear.wav" )
end




