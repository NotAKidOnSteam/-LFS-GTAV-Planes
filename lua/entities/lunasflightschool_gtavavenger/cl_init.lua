-- YOU CAN EDIT AND REUPLOAD THIS FILE. 
-- HOWEVER MAKE SURE TO RENAME THE FOLDER TO AVOID CONFLICTS

include("shared.lua")


function ENT:Think()
	self:AnimCabin()
	self:AnimLandingGear()
	self:AnimBombsDoor()
	self:AnimDoorBay()
	self:AnimRotor()
	self:AnimFins()
	self:CheckEngineState()
	self:ExhaustFX()
	self:DamageFX()
end


function ENT:LFSCalcViewFirstPerson( view, ply ) -- modify first person camera view here
	--[[
	if ply == self:GetDriver() then
		-- driver view
	elseif ply == self:GetGunner() then
		-- gunner view
	else
		-- everyone elses view
	end
	]]--
	
	return view
end

function ENT:LFSCalcViewThirdPerson( view, ply ) -- modify third person camera view here
	return view
end



function ENT:LFSHudPaintPassenger( X, Y, ply ) -- all except driver
end

function ENT:CalcEngineSound( RPM, Pitch, Doppler )

	if self.ENG then

		self.ENG:ChangePitch(  math.Clamp(math.Clamp(  60 + Pitch * 50, 80,255) + Doppler,0,255) )

		self.ENG:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0.5,1) )

	end

	

	if self.DIST then

		self.DIST:ChangePitch(  math.Clamp(math.Clamp(  Pitch * 100, 50,255) + Doppler * 1.25,0,255) )

		self.DIST:ChangeVolume( math.Clamp( -1.5 + Pitch * 6, 0.5,1) )

	end

end

function ENT:LFSCalcViewFirstPerson( view ) -- modify first person camera view here
	
	local ply = LocalPlayer()
	if ply == self:GetDriver() then
		self:LocalToWorld( Vector(50,0,-30) )
	end
	
	
	return view
end

function ENT:CalcEngineSound( RPM, Pitch, Doppler )
	local Low = 500
	local Low2 = 600
	local Mid = 700
	local High = 950
	
	if self.RPM1 then
		self.RPM1:ChangePitch( math.Clamp(100 + Pitch * 2 + Doppler,0,255) * 0.8 )
		self.RPM1:ChangeVolume( RPM < Low and 1 or 0, 1.5 )
	end
	
	if self.VTOL then
		self.VTOL:ChangePitch( math.Clamp(100 + Pitch * 2 + Doppler,0,255) * 0.8 )
		self.VTOL:ChangeVolume( RPM < Low and 1 or 0, 1.5 )
	end

	if self.LOWRPM then
		self.LOWRPM:ChangePitch( math.Clamp(100 + Pitch * 2 + Doppler,0,255) * 0.8 )
		self.LOWRPM:ChangeVolume( RPM < Low and 1 or 0, 1.5 )
	end
	
	if self.RPM2 then
		self.RPM2:ChangePitch(  math.Clamp(100 + Pitch * 10 + Doppler,0,255) * 0.8 )
		self.RPM2:ChangeVolume( (RPM >= Low and RPM < Mid) and 1 or 0, 1.5 )
	end
	
	if self.AIRNOISE then
		self.AIRNOISE:ChangePitch( math.Clamp(100 + Pitch * 2 + Doppler,0,255) * 0.8 )
		self.AIRNOISE:ChangeVolume( RPM > Low2 and 1 or 0, 1.5 )
	end	
	
	if self.RPM3 then
		self.RPM3:ChangePitch(  math.Clamp(100 + Pitch * 20 + Doppler,0,255) * 0.8 )
		self.RPM3:ChangeVolume( (RPM >= Mid and RPM < High) and 1 or 0, 1.5 )
	end
	
	if self.RPM4 then
		self.RPM4:ChangePitch(  math.Clamp(100 + Pitch * 30 + Doppler,0,255) * 0.8 )
		self.RPM4:ChangeVolume( RPM >= High and 1 or 0, 1.5 )
	end
	
	if self.THRUST then
		self.THRUST:ChangePitch(  math.Clamp(100 + Pitch * 30 + Doppler,0,255) * 0.8 )
		self.THRUST:ChangeVolume( RPM >= High and 0.5 or 0, 1 )
	end	
	
	if self.DIST then
		self.DIST:ChangePitch(  math.Clamp(math.Clamp(  50 + Pitch * 60, 50,255) + Doppler,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0,1) )
	end
end

function ENT:EngineActiveChanged( bActive )
	if bActive then
		self.RPM1 = CreateSound( self, "GTAV_AVENGER_RPM1" )
		self.RPM1:PlayEx(0,0)
		
		self.VTOL = CreateSound( self, "GTAV_AVENGER_VTOL" )
		self.VTOL:PlayEx(0,0)
		
		self.RPM2 = CreateSound( self, "GTAV_AVENGER_RPM2" )
		self.RPM2:PlayEx(0,0)
		
		self.AIRNOISE = CreateSound( self, "GTAV_AVENGER_PROP" )
		self.AIRNOISE:PlayEx(0,0)
		
		self.RPM3 = CreateSound( self, "GTAV_AVENGER_RPM3" )
		self.RPM3:PlayEx(0,0)
		
		self.RPM4 = CreateSound( self, "GTAV_AVENGER_RPM4" )
		self.RPM4:PlayEx(0,0)
		
		self.THRUST = CreateSound( self, "GTAV_AVENGER_THRUST" )
		self.THRUST:PlayEx(0,0)
		
		self.LOWRPM = CreateSound( self, "GTAV_AVENGER_THRUST" )
		self.LOWRPM:PlayEx(0,0)
		
		self.DIST = CreateSound( self, "GTAV_JET_DIST" )
		self.DIST:PlayEx(0,0)
	else
		self:SoundStop()
	end
end

function ENT:OnRemove()
	self:SoundStop()
end

function ENT:SoundStop()
	if self.RPM1 then
		self.RPM1:Stop()
	end
	if self.RPM2 then
		self.RPM2:Stop()
	end
	if self.VTOL then
		self.VTOL:Stop()
	end
	if self.AIRNOISE then
		self.AIRNOISE:Stop()
	end
	if self.RPM3 then
		self.RPM3:Stop()
	end
	if self.RPM4 then
		self.RPM4:Stop()
	end
	
	if self.THRUST then
		self.THRUST:Stop()
	end	
	
	if self.DIST then
		self.DIST:Stop()
	end
end

function ENT:AnimFins()
	--[[ function gets called each frame by the base script. you can do whatever you want here ]]--
	
	self.smYaw2 = self.smYaw2 and self.smYaw2 + (self:GetRotYaw() - self.smYaw2) * FrameTime() * 2 or 0
	self.smRoll2 = self.smRoll2 and self.smRoll2 + (self:GetRotRoll() - self.smRoll2) * FrameTime() * 2 or 0
	
	local OnGround = self:GetOnGround()
	
	if OnGround then
		self.smYaw2 = 0
		self.smRoll2 = 0
	end

	self.SMLG2 = self.SMLG2 and self.SMLG2 + (self:GetLGear() - self.SMLG2) * FrameTime() * 5 or 0
	
	local ang = self.smYaw2 * self.SMLG2 - self.smRoll2/2 * (2 - self.SMLG2)
	local Mov = (self:GetRPM() / self:GetLimitRPM()) * 90 * self.SMLG2
	
	local Wing1 = -90 * self.SMLG2 - ang + Mov
	local Wing2 = -90 * self.SMLG2 + ang + Mov
	
	self:ManipulateBoneAngles( 2, Angle( 0,0,Wing1 ) )
	self:ManipulateBoneAngles( 4, Angle( 0,0,Wing2 ) )
	
	local FT = FrameTime() * 10
	local Pitch = self:GetRotPitch()
	local Yaw = self:GetRotYaw()
	local Roll = -self:GetRotRoll()
	self.smPitch = self.smPitch and self.smPitch + (Pitch - self.smPitch) * FT or 0
	self.smYaw = self.smYaw and self.smYaw + (Yaw - self.smYaw) * FT or 0
	self.smRoll = self.smRoll and self.smRoll + (Roll - self.smRoll) * FT or 0

	self:ManipulateBoneAngles(35,Angle(0,-self.smRoll/2,-self.smPitch/2))
	self:ManipulateBoneAngles(36,Angle(0,-self.smRoll/2,-self.smPitch/2))
	self:ManipulateBoneAngles( 6, Angle( -self.smRoll/2) )
	self:ManipulateBoneAngles( 7, Angle( -self.smRoll/2) )
	

	
	self:ManipulateBoneAngles( 10, Angle( 0,0,self.smPitch) )
	self:ManipulateBoneAngles( 8, Angle( self.smYaw,0,0) )
	self:ManipulateBoneAngles( 9, Angle( self.smYaw,0,0) )
end

function ENT:AnimRotor()
	local RPM = self:GetRPM()
	local PhysRot = RPM < 1000
	self.RPM = self.RPM and (self.RPM + RPM * FrameTime() * (PhysRot and 3 or 1)) or 0
	
	local Rot = Angle( self.RPM,0,0)
	Rot:Normalize() 
	self:ManipulateBoneAngles( 22, Rot )
	self:ManipulateBoneAngles( 23, -Rot )
	
	self:SetBodygroup( 1, PhysRot and 0 or 1 ) 
	self:SetBodygroup( 2, PhysRot and 0 or 1 ) 
end

function ENT:AnimCabin()
	local bOn = self:GetActive()
	local locked = self:GetNWBool("carKeysVehicleLocked")
	
	local TVal = bOn and 1 or 0
	local lock = locked and 1 or 0
	local Speed = FrameTime() * 4
	if bOn and not locked then
		self.Door = self.Door and self.Door + (126 *  (1 - TVal) - self.Door) * FrameTime() * 2 or 0
	elseif bOn and locked then
		self.Door = self.Door and self.Door + (126 *  (1 - TVal) - self.Door) * FrameTime() * 2 or 0
	elseif not bOn and locked then
		self.Door = self.Door and self.Door + (126 *  (1 - lock) - self.Door) * FrameTime() * 2 or 0
	elseif not bOn and not locked then
		self.Door = self.Door and self.Door + (126 *  (1 - lock) - self.Door) * FrameTime() * 2 or 0
	end

	self:ManipulateBoneAngles( 11, Angle( 0,-self.Door  ) )
	self:ManipulateBoneAngles( 12, Angle( 0,self.Door  ) )
end

function ENT:AnimLandingGear()
	self.SMLG = self.SMLG and self.SMLG + (90 * (1 - self:GetRGear()) - self.SMLG) * FrameTime() * 4 or 0 
	self.SMRG = self.SMRG and self.SMRG + (-32.5 *  (1 - self:GetLGear()) - self.SMRG) * FrameTime() * 2 or 0
	
	self.SFGD = self.SFGD and self.SFGD + (90 *  (1 - self:GetLGear()) - self.SFGD) * FrameTime() * 2 or 0
	
	--IJWSBDFIJDSBFOJNDSFJON
	self:ManipulateBoneAngles( 13, Angle( 0,-self.SFGD,0  ) )
	self:ManipulateBoneAngles( 14, Angle( 0,0,self.SFGD  ) )
	self:ManipulateBoneAngles( 15, Angle( 0,self.SFGD,0  ) )
	self:ManipulateBoneAngles( 16, Angle( 0,-self.SFGD,0  ) )
	self:ManipulateBoneAngles( 17, Angle( 0,self.SFGD,0  ) )
	self:ManipulateBoneAngles( 18, Angle( 0,self.SFGD,0  ) )
	self:ManipulateBoneAngles( 19, Angle( 0,-self.SFGD,0  ) )
	self:ManipulateBonePosition( 3, Vector( 0,1 * self.SFGD/2.6) )
	self:ManipulateBonePosition( 5, Vector( 0,1 * self.SFGD/2.6) )
end

function ENT:ExhaustFX()
	--[[ function gets called each frame by the base script. you can do whatever you want here ]]--
end

function ENT:AnimDoorBay()
	self.Door2 = self.Door2 and self.Door2 + (-32.5 *  (1 - self:GetDoorOpenNum()) - self.Door2) * FrameTime() * 1.7 or 0

	self:ManipulateBoneAngles( 34, Angle( 0,0,self.Door2  ) ) --boot
end

local mat = Material( "sprites/light_glow02_add" )

function ENT:Draw()
	self:DrawModel()
	
	if self:GetEngineActive() then
		local Alpha = math.abs( math.cos( CurTime() * 5 ) ) * 30
		render.SetMaterial( mat )
		render.DrawSprite( self:LocalToWorld( Vector(-366.817,134.123,172.176) ), Alpha, Alpha, Color( 255, 0, 0, 255) )
		render.DrawSprite( self:LocalToWorld( Vector(-366.817,134.123,170.176) ), Alpha, Alpha, Color( 255, 0, 0, 255) )
		render.DrawSprite( self:LocalToWorld( Vector(-366.817,134.123,170.176) ), Alpha, Alpha, Color( 255, 0, 0, 255) )
	end
	
	if self:GetLGear() == 0 then
		render.SetMaterial( mat )
		render.DrawSprite( self:LocalToWorld( Vector(323.5,41.795,-1.689) ), 5, 5, Color( 0, 127, 31, 255 ) )
		
	elseif self:GetLGear() == 1 then
		render.SetMaterial( mat )
		render.DrawSprite( self:LocalToWorld( Vector(323.5,40.107,-1.689) ), 5, 5, Color( 0, 127, 31, 255 ) )
	end
	
	
end

function ENT:AnimBombsDoor()
	self.animbomb = self.animbomb and self.animbomb + (120 *  (1 - self:GetBayOpen()) - self.animbomb) * FrameTime() * 2 or 0
	self:ManipulateBoneAngles( 20, Angle( 0,self.animbomb ) )
	self:ManipulateBoneAngles( 21, Angle( 0,-self.animbomb ) )
end

function ENT:LFSHudPaint( X, Y, data, ply ) -- driver only
	if not IsValid( self ) then return end

	if self:GetMaxBombsAmmo() > -1 then

		draw.SimpleText( "BOMB", "LFS_FONT", 10, 85, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		draw.SimpleText( self:GetBombsAmmo(), "LFS_FONT", 120, 85, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	end 
end