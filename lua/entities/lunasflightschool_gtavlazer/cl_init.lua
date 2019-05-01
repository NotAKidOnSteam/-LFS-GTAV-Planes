--DO NOT EDIT OR REUPLOAD THIS FILE

include("shared.lua")




function ENT:ExhaustFX()

	nak_lazer_no_exhaust = GetConVar( "nak_lazer_no_exhaust" )
	if nak_lazer_no_exhaust:GetBool() == true then return end	

	if not self:GetEngineActive() then return end

	

	self.nextEFX = self.nextEFX or 0

	

	local THR = (self:GetRPM() / (self.LimitRPM - self.IdleRPM) / 2)

	

	local Driver = self:GetDriver()

	if IsValid( Driver ) then

		local W = Driver:KeyPressed( IN_FORWARD )


		if W ~= self.oldW then

			self.oldW = W

			if W then

				self.BoostAdd = 120

			end

		end

	end

	

	self.BoostAdd = self.BoostAdd and (self.BoostAdd - self.BoostAdd * FrameTime()) or 0

	

	if self.nextEFX then

		self.nextEFX = CurTime() + 0.5

		

		local emitter = ParticleEmitter( self:GetPos(), false )


		local Pos = {

			Vector(-188.341,0,100.752),
			Vector(-188.341,0,100.752),
			Vector(-188.341,0,100.752),
			Vector(-188.341,0,100.752),
			Vector(-188.341,0,100.752),
		}



		

		if emitter then

			for _, v in pairs( Pos ) do


				local vOffset = self:LocalToWorld( v )

				local vNormal = -self:GetForward()



				vOffset = vOffset + vNormal * 5  



				local particle = emitter:Add( "effects/muzzleflash2", vOffset )

				if not particle then return end



				particle:SetVelocity( vNormal * math.Rand(500,1000) + self:GetVelocity() )

				particle:SetLifeTime( 0.1 )

				particle:SetDieTime( THR )

				particle:SetStartAlpha( 255 )

				particle:SetEndAlpha( 0 )

				particle:SetStartSize( math.Rand(25,30) )

				particle:SetEndSize( math.Rand(2,15) )

				particle:SetRoll( math.Rand(-1,1) * 100 )

				

				particle:SetColor( 255, 91, 0 )

			end

			

			emitter:Finish()

		end

	end

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
	local Mid = 700
	local High = 950
	
	if self.RPM1 then
		self.RPM1:ChangePitch( math.Clamp(100 + Pitch * 2 + Doppler,0,255) * 0.8 )
		self.RPM1:ChangeVolume( RPM < Low and 1 or 0, 1.5 )
	end
	
	if self.RPM2 then
		self.RPM2:ChangePitch(  math.Clamp(100 + Pitch * 10 + Doppler,0,255) * 0.8 )
		self.RPM2:ChangeVolume( (RPM >= Low and RPM < Mid) and 1 or 0, 1.5 )
	end
	
	if self.AIRNOISE then
		self.AIRNOISE:ChangePitch(  math.Clamp(100 + Pitch * 20 + Doppler,0,255) * 0.8 )
		self.AIRNOISE:ChangeVolume( (RPM >= Mid and RPM < High) and 1 or 0, 1.5 )
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
		self.RPM1 = CreateSound( self, "GTAV_JET_RPM1" )
		self.RPM1:PlayEx(0,0)
		
		self.RPM2 = CreateSound( self, "GTAV_JET_RPM2" )
		self.RPM2:PlayEx(0,0)
		
		self.AIRNOISE = CreateSound( self, "GTAV_JET_AIRNOISE" )
		self.AIRNOISE:PlayEx(0,0)
		
		self.RPM3 = CreateSound( self, "GTAV_JET_RPM3" )
		self.RPM3:PlayEx(0,0)
		
		self.RPM4 = CreateSound( self, "GTAV_JET_RPM4" )
		self.RPM4:PlayEx(0,0)
		
		self.THRUST = CreateSound( self, "GTAV_JET_THRUST" )
		self.THRUST:PlayEx(0,0)
		
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
	local FT = FrameTime() * 10
	local Pitch = self:GetRotPitch()
	local Yaw = self:GetRotYaw()
	local Roll = -self:GetRotRoll()
	self.smPitch = self.smPitch and self.smPitch + (Pitch - self.smPitch) * FT or 0
	self.smYaw = self.smYaw and self.smYaw + (Yaw - self.smYaw) * FT or 0
	self.smRoll = self.smRoll and self.smRoll + (Roll - self.smRoll) * FT or 0
	
	self:ManipulateBoneAngles( 1, Angle( 0,0,-self.smRoll / 2) )
	self:ManipulateBoneAngles( 2, Angle( 0,0,self.smRoll / 2) )
	
	self:ManipulateBoneAngles( 3, Angle( 0,0,-self.smPitch / 2) )
	self:ManipulateBoneAngles( 16, Angle( 0,0,-self.smPitch / 2) )
	self:ManipulateBoneAngles( 9, Angle( -self.smYaw / 1.5,0,0) )
	self:ManipulateBoneAngles( 10, Angle( -self.smYaw / 1.5,0,0) )
	--self:ManipulateBoneAngles( 5, Angle( 0,self.smYaw,0 ) )
end

function ENT:AnimRotor()

end

function ENT:AnimCabin()
	local bOn = self:GetActive()
	
	local TVal = bOn and 0 or 1
	
	local Speed = FrameTime() * 4
	
	self.SMcOpen = self.SMcOpen and self.SMcOpen + math.Clamp(TVal - self.SMcOpen,-Speed,Speed) or 0
	
	--self:ManipulateBonePosition( 11, Vector( 0,-self.SMcOpen * 18,self.SMcOpen * 1.5) ) 
	self:ManipulateBoneAngles( 15, Angle( 0,0,self.SMcOpen * 45 ) )
end


function ENT:AnimLandingGear()
	self.SMLG = self.SMLG and self.SMLG + (100 * (1 - self:GetRGear()) - self.SMLG) * FrameTime() * 4 or 0 
	self.SMLG2 = self.SMLG2 and self.SMLG2 + (90 * (1 - self:GetRGear()) - self.SMLG2) * FrameTime() * 4 or 0 
	self.SMRG = self.SMRG and self.SMRG + (88 *  (1 - self:GetLGear()) - self.SMRG) * FrameTime() * 2 or 0
	self.SMRG2 = self.SMRG2 and self.SMRG2 + (120 *  (1 - self:GetLGear()) - self.SMRG2) * FrameTime() * 2 or 0
	self.SFGD = self.SFGD and self.SFGD + (38 *  (1 - self:GetLGear()) - self.SFGD) * FrameTime() * 2 or 0
	self.SFGD2 = self.SFGD2 and self.SFGD2 + (110.5 *  (1 - self:GetLGear()) - self.SFGD2) * FrameTime() * 2 or 0
	--IJWSBDFIJDSBFOJNDSFJON
	self:ManipulateBoneAngles( 5, Angle( -self.SFGD,self.SMLG2,self.SMLG  ) )
	self:ManipulateBoneAngles( 6, Angle( 0,0,-self.SMRG2 ) )
	self:ManipulateBoneAngles( 7, Angle( self.SMRG ) )
	self:ManipulateBoneAngles( 8, Angle( self.SFGD,-self.SMLG2,self.SMLG  ) )
	--[[
	self:ManipulateBoneAngles( 11, Angle( 0,0,self.SFGD ) )
	self:ManipulateBoneAngles( 12, Angle( 0,0,self.SFGD ) )
	--]]
	self:ManipulateBoneAngles( 21, Angle( 0,0,self.SFGD ) )
	self:ManipulateBoneAngles( 13, Angle( -self.SFGD2  ) )
	self:ManipulateBoneAngles( 14, Angle( self.SFGD2  ) )
end







