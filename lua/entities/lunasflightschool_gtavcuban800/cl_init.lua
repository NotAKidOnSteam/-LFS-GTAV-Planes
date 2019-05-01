--DO NOT EDIT OR REUPLOAD THIS FILE

include("shared.lua")

function ENT:ExhaustFX()
	if not self:GetEngineActive() then return end
	
	self.nextEFX = self.nextEFX or 0
	
	local THR = (self:GetRPM() - self.IdleRPM) / (self.LimitRPM - self.IdleRPM)
	
	if self.nextEFX < CurTime() then
		self.nextEFX = CurTime() + 0.05 + (1 - THR) / 10
		
		local Pos = {
			Vector(12.526,73.877,64.007),
			Vector(12.526,91.209,64.007),
			Vector(12.526,73.877,64.007),
			Vector(12.526,91.209,64.007),
		}
		
		for _, v in pairs(Pos) do 
			if math.random(0,1) == 1 then
				local effectdata = EffectData()
					effectdata:SetOrigin( v )
					effectdata:SetAngles( Angle(-90,-20,0) )
					effectdata:SetMagnitude( math.Clamp(THR,0.2,1) ) 
					effectdata:SetEntity( self )
				util.Effect( "lfs_exhaust", effectdata )
			end
			
			if math.random(0,1) == 1 then
				local vr = v
				vr.y = -v.y
				
				local effectdata = EffectData()
					effectdata:SetOrigin( vr )
					effectdata:SetAngles( Angle(-90,20,0) )
					effectdata:SetMagnitude( math.Clamp(THR,0.2,1) ) 
					effectdata:SetEntity( self )
				util.Effect( "lfs_exhaust", effectdata )
			end
		end
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
		self.RPM1 = CreateSound( self, "LFS_SPITFIRE_RPM1" )
		self.RPM1:PlayEx(0,0)
		
		self.RPM2 = CreateSound( self, "LFS_SPITFIRE_RPM2" )
		self.RPM2:PlayEx(0,0)
		
		self.RPM3 = CreateSound( self, "LFS_SPITFIRE_RPM3" )
		self.RPM3:PlayEx(0,0)
		
		self.RPM4 = CreateSound( self, "LFS_SPITFIRE_RPM4" )
		self.RPM4:PlayEx(0,0)
		
		self.DIST = CreateSound( self, "LFS_SPITFIRE_DIST" )
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
	
	self:ManipulateBoneAngles( 3, Angle( 0,0,-self.smPitch) )
	self:ManipulateBoneAngles( 12, Angle( -self.smYaw,0,0) )
	
	--self:ManipulateBoneAngles( 5, Angle( 0,self.smYaw,0 ) )
end

function ENT:AnimRotor()
	local RPM = self:GetRPM()
	local PhysRot = RPM < 1000
	self.RPM = self.RPM and (self.RPM + RPM * FrameTime() * (PhysRot and 3 or 1)) or 0
	
	local Rot = Angle( self.RPM,0,0)
	Rot:Normalize() 
	self:ManipulateBoneAngles( 13, Rot )
	self:ManipulateBoneAngles( 14, -Rot )
	
	self:SetBodygroup( 1, PhysRot and 0 or 1 ) 
	self:SetBodygroup( 2, PhysRot and 0 or 1 ) 
end
--[[
function ENT:AnimCabin()
	local bOn = self:GetActive()
	
	local TVal = bOn and 0 or 1
	
	local Speed = FrameTime() * 4
	
	self.SMcOpen = self.SMcOpen and self.SMcOpen + math.Clamp(TVal - self.SMcOpen,-Speed,Speed) or 0
	
	self:ManipulateBonePosition( 11, Vector( 0,-self.SMcOpen * 18,self.SMcOpen * 1.5) ) 
end

--]]
function ENT:AnimLandingGear()
	self.SMLG = self.SMLG and self.SMLG + (90 * (1 - self:GetRGear()) - self.SMLG) * FrameTime() * 4 or 0 
	self.SMRG = self.SMRG and self.SMRG + (105 *  (1 - self:GetLGear()) - self.SMRG) * FrameTime() * 2 or 0
	
	self.SFGD = self.SFGD and self.SFGD + (90 *  (1 - self:GetLGear()) - self.SFGD) * FrameTime() * 2 or 0
	--IJWSBDFIJDSBFOJNDSFJON
	self:ManipulateBoneAngles( 7, Angle( -self.SFGD,0  ) )
	self:ManipulateBoneAngles( 8, Angle( self.SFGD,0  ) )
	self:ManipulateBoneAngles( 9, Angle( -self.SFGD,0  ) )
	self:ManipulateBoneAngles( 5, Angle( self.SFGD,0  ) )
	self:ManipulateBoneAngles( 6, Angle( 0,0,-self.SMRG  ) )
end



local mat = Material( "sprites/glow_wing_light" )
function ENT:Draw()
	self:DrawModel()
	
	if not self:GetEngineActive() then return end
	
	local Size = 30 
	local Mirror = false
	for i = 0,1 do
		local Sub = Mirror and 1 or -1
		local pos = self:LocalToWorld( Vector(66.058,148.919 * Sub,65.085) )
		
		render.SetMaterial( mat )
		render.DrawSprite( pos, Size, Size, Color( 255, 255, 255, 255 ) )
		Mirror = true
	end
end


