--DO NOT EDIT OR REUPLOAD THIS FILE

include("shared.lua")


function ENT:Think()

	self:AnimCabin()

	self:AnimLandingGear()
	self:AnimBombsDoor()

	self:AnimRotor()

	self:AnimFins()

	

	self:CheckEngineState()

	

	self:ExhaustFX()

	self:DamageFX()

end


function ENT:ExhaustFX()
	

	nak_no_exhaust = GetConVar( "nak_no_exhaust" )
	if nak_no_exhaust:GetBool() == true then return end		

	if not self:GetEngineActive() then return end

	

	self.nextEFX = self.nextEFX or 0

	if self:GetBoosting() then
		self.IsBoosting = 1 
	else
		self.IsBoosting = 4
	end
	

	local THR = (self:GetRPM() / (self.LimitRPM - self.IdleRPM) * 4 / self.IsBoosting)



	if self.nextEFX then

		self.nextEFX = CurTime() + 0.08

		

		local emitter = ParticleEmitter( self:GetPos(), false )


		local Pos = {

			Vector(-132,0,94),
			Vector(-132,0,94),
			Vector(-132,0,94),
			Vector(-132,0,94),
			Vector(-132,0,94),
		}



		

		if emitter then

			for _, v in pairs( Pos ) do


				local vOffset = self:LocalToWorld( v )

				local vNormal = -self:GetForward()



				vOffset = vOffset + vNormal * 5  



				local particle = emitter:Add( "effects/muzzleflash2", vOffset )

				if not particle then return end



				particle:SetVelocity( vNormal * math.Rand(200,500) + self:GetVelocity() )

				particle:SetLifeTime( 0.1 )

				particle:SetDieTime( THR/1.5 )

				particle:SetStartAlpha( 255 )

				particle:SetEndAlpha( 0 )

				particle:SetStartSize( math.Rand(10,15) )

				particle:SetEndSize( math.Rand(8,10) )



				

				particle:SetColor( 255, 91, 0 )

			end

			

			emitter:Finish()

		end

	end

end

function ENT:CalcEngineSound( RPM, Pitch, Doppler )
	local Low = 500
	local Mid = 700
	local High = 950
	
	if self.RPM1 then
		self.RPM1:ChangePitch( math.Clamp(100 + Pitch * 200 + Doppler,0,255) * 0.8 )
		self.RPM1:ChangeVolume( RPM < Low and 1 or 0, 1.5 )
	end
	
	if self.RPM2 then
		self.RPM2:ChangePitch(  math.Clamp(50 + Pitch * 260 + Doppler,0,255) * 0.8 )
		self.RPM2:ChangeVolume( (RPM >= Low and RPM < Mid) and 1 or 0, 1.5 )
	end
	
	if self.RPM3 then
		self.RPM3:ChangePitch(  math.Clamp(75 + Pitch * 110 + Doppler,0,255) * 0.8 )
		self.RPM3:ChangeVolume( (RPM >= Mid and RPM < High) and 1 or 0, 1.5 )
	end
	
	if self.RPM4 then
		self.RPM4:ChangePitch(  math.Clamp(90 + Pitch * 50 + Doppler,0,255) * 0.8 )
		self.RPM4:ChangeVolume( RPM >= High and 1 or 0, 1.5 )
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
	if self.RPM3 then
		self.RPM3:Stop()
	end
	if self.RPM4 then
		self.RPM4:Stop()
	end
	if self.AIRNOISE then
		self.AIRNOISE:Stop()
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
	
	self:ManipulateBoneAngles( 1, Angle( 0,0,-self.smRoll) )
	self:ManipulateBoneAngles( 2, Angle( 0,0,self.smRoll) )
	self:ManipulateBoneAngles( 5, Angle( 0,0,-self.smRoll) )
	self:ManipulateBoneAngles( 6, Angle( 0,0,self.smRoll) )
	
	self:ManipulateBoneAngles( 9, Angle( 0,0,-self.smPitch) )
	self:ManipulateBoneAngles( 11, Angle( 0,0,-self.smPitch) )
	self:ManipulateBoneAngles( 10, Angle(self.smYaw/2) )
	
	--self:ManipulateBoneAngles( 3, Angle( 0,0,-self.smPitch) )
	--self:ManipulateBoneAngles( 4, Angle( -self.smYaw,0,0) )
	
	--self:ManipulateBoneAngles( 5, Angle( 0,self.smYaw,0 ) )
end

function ENT:AnimRotor()
	local RPM = self:GetRPM()
	local PhysRot = RPM < 1000
	self.RPM = self.RPM and (self.RPM + RPM * FrameTime() * (PhysRot and 3 or 1)) or 0
	
	local Rot = Angle( self.RPM,0,0)
	Rot:Normalize() 
	self:ManipulateBoneAngles( 8, Rot )

	
	
	self:SetBodygroup( 1, PhysRot and 0 or 1 ) 
end

function ENT:AnimCabin()
	local bOn = self:GetActive()
	
	local TVal = bOn and 0 or 1
	
	local Speed = FrameTime() * 4
	
	self.SMcOpen = self.SMcOpen and self.SMcOpen + math.Clamp(TVal - self.SMcOpen,-Speed,Speed) or 0
	
	--self:ManipulateBonePosition( 11, Vector( 0,-self.SMcOpen * 18,self.SMcOpen * 1.5) ) 
	self:ManipulateBoneAngles( 7, Angle( 0,0,self.SMcOpen * 103 ) )
end

local mat = Material( "sprites/glow_wing_light" )
function ENT:Draw()
	self:DrawModel()
	

	if self:GetBayOpen()  < 0.1 then
		for i = 0,1 do
			
			local pos = self:LocalToWorld( Vector(45,2.608,108.52) )
			
			render.SetMaterial( mat )
			render.DrawSprite( pos, 2, 2, Color( 63, 127, 0, 255 ) )
		end
	else
		for i = 0,0.1 do
			
			local pos = self:LocalToWorld( Vector(45,2.608,108.52) )
			
			render.SetMaterial( mat )
			render.DrawSprite( pos, 2, 2, Color( 255, 0, 0, 255 ) )
		end
	end
	
	local Driver = self:GetDriver()
	--if shooting
	if IsValid( Driver ) and self:GetBombsTime() < CurTime() then
		for i = 0,1 do
			
			local pos = self:LocalToWorld( Vector(51.7,2.01,111.06) )
			
			render.SetMaterial( mat )
			render.DrawSprite( pos, 2, 2, Color( 63, 127, 0, 255 ) )
		end
	else
		for i = 0,0.1 do
			
			local pos = self:LocalToWorld( Vector(51.7,2.01,111.06) )
			
			render.SetMaterial( mat )
			render.DrawSprite( pos, 2, 2, Color( 255, 0, 0, 255 ) )
		end
	end
end

function ENT:AnimBombsDoor()
	self.SMRG = self.SMRG and self.SMRG + (50 *  (1 - self:GetBayOpen()) - self.SMRG) * FrameTime() * 2 or 0
	self:ManipulateBoneAngles( 4, Angle( self.SMRG ) )
	self:ManipulateBoneAngles( 3, Angle( -self.SMRG ) )
end
