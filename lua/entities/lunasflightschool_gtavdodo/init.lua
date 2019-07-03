--DO NOT EDIT OR REUPLOAD THIS FILE

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")


function ENT:SpawnFunction( ply, tr, ClassName )

	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal * 120 + Vector(0,0,-90) )
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:OnTick(ent)
	--i would make this with a for loop instead of spawning all 8 manually but when I first coded this I didnt use the local pos for the plane but instead used getpos() and getforward,getright,and getup.. yeet
	if self.SpawnedFloats == false then
		self.SpawnedFloats = true

		self.floaty = ents.Create("prop_physics")
		self.floaty:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty:SetPos(self:GetPos() + self:GetForward() * -120 + self:GetRight() * 60 + self:GetUp() * 40   )
		self.floaty:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty:Spawn()
		self.floaty:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty, 0, 0, 0, true )
		self.floaty:Activate()
		self.floaty:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		self.floaty2 = ents.Create("prop_physics")
		self.floaty2:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty2:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty2:SetPos(self:GetPos() + self:GetForward() * -120 + self:GetRight() * -60 + self:GetUp() * 40   )
		self.floaty2:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty2:Spawn()
		self.floaty2:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty2, 0, 0, 0, true )
		self.floaty2:Activate()
		self.floaty2:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty2:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		self.floaty3 = ents.Create("prop_physics")
		self.floaty3:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty3:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty3:SetPos(self:GetPos() + self:GetForward() * -60 + self:GetRight() * 60 + self:GetUp() * 40   )
		self.floaty3:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty3:Spawn()
		self.floaty3:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty3, 0, 0, 0, true )
		self.floaty3:Activate()
		self.floaty3:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty3:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		self.floaty4 = ents.Create("prop_physics")
		self.floaty4:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty4:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty4:SetPos(self:GetPos() + self:GetForward() * -60 + self:GetRight() * -60 + self:GetUp() * 40   )
		self.floaty4:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty4:Spawn()
		self.floaty4:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty4, 0, 0, 0, true )
		self.floaty4:Activate()
		self.floaty4:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty4:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		self.floaty5 = ents.Create("prop_physics")
		self.floaty5:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty5:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty5:SetPos(self:GetPos() + self:GetForward() * -0 + self:GetRight() * 60 + self:GetUp() * 40   )
		self.floaty5:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty5:Spawn()
		self.floaty5:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty5, 0, 0, 0, true )
		self.floaty5:Activate()
		self.floaty5:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty5:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		self.floaty6 = ents.Create("prop_physics")
		self.floaty6:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty6:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty6:SetPos(self:GetPos() + self:GetForward() * -0 + self:GetRight() * -60 + self:GetUp() * 40   )
		self.floaty6:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty6:Spawn()
		self.floaty6:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty6, 0, 0, 0, true )
		self.floaty6:Activate()
		self.floaty6:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty6:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		self.floaty7 = ents.Create("prop_physics")
		self.floaty7:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty7:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty7:SetPos(self:GetPos() + self:GetForward() * 60 + self:GetRight() * 60 + self:GetUp() * 40   )
		self.floaty7:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty7:Spawn()
		self.floaty7:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty7, 0, 0, 0, true )
		self.floaty7:Activate()
		self.floaty7:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty7:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		self.floaty8 = ents.Create("prop_physics")
		self.floaty8:SetCollisionGroup(COLLISION_GROUP_NONE)	
		self.floaty8:SetModel("models/props_c17/oildrum001.mdl")
		self.floaty8:SetPos(self:GetPos() + self:GetForward() * 60 + self:GetRight() * -60 + self:GetUp() * 40  )
		self.floaty8:SetAngles(Angle(90,self:GetAngles(),self:GetAngles()))
		self.floaty8:Spawn()
		self.floaty8:GetPhysicsObject():SetMass(10)
		constraint.Weld( self, self.floaty8, 0, 0, 0, true )
		self.floaty8:Activate()
		self.floaty8:GetPhysicsObject():SetDragCoefficient(-9000000)
		self.floaty8:GetPhysicsObject():SetBuoyancyRatio( 10 )
		
		constraint.NoCollide( self.floaty8, self, 0, 0, true )
		constraint.NoCollide( self.floaty7, self, 0, 0, true )
		constraint.NoCollide( self.floaty6, self, 0, 0, true )
		constraint.NoCollide( self.floaty5, self, 0, 0, true )
		constraint.NoCollide( self.floaty4, self, 0, 0, true )
		constraint.NoCollide( self.floaty3, self, 0, 0, true )
		constraint.NoCollide( self.floaty2, self, 0, 0, true )
		constraint.NoCollide( self.floaty, self, 0, 0, true )
		
		
		self.floaty:SetColor( 255, 255, 255, 0 )
		self.floaty:SetNoDraw( true )
		self.floaty:DrawShadow( false )
		self.floaty2:SetColor( 255, 255, 255, 0 )
		self.floaty2:SetNoDraw( true )
		self.floaty2:DrawShadow( false )
		self.floaty3:SetColor( 255, 255, 255, 0 )
		self.floaty3:SetNoDraw( true )
		self.floaty3:DrawShadow( false )
		self.floaty4:SetColor( 255, 255, 255, 0 )
		self.floaty4:SetNoDraw( true )
		self.floaty4:DrawShadow( false )
		self.floaty5:SetColor( 255, 255, 255, 0 )
		self.floaty5:SetNoDraw( true )
		self.floaty5:DrawShadow( false )
		self.floaty6:SetColor( 255, 255, 255, 0 )
		self.floaty6:SetNoDraw( true )
		self.floaty6:DrawShadow( false )
		self.floaty7:SetColor( 255, 255, 255, 0 )
		self.floaty7:SetNoDraw( true )
		self.floaty7:DrawShadow( false )
		self.floaty8:SetColor( 255, 255, 255, 0 )
		self.floaty8:SetNoDraw( true )
		self.floaty8:DrawShadow( false )
	end

	self:DeleteOnRemove( self.floaty8 )
	self:DeleteOnRemove( self.floaty7 )
	self:DeleteOnRemove( self.floaty6 )
	self:DeleteOnRemove( self.floaty5 )
	self:DeleteOnRemove( self.floaty4 )
	self:DeleteOnRemove( self.floaty3 )
	self:DeleteOnRemove( self.floaty2 )
	self:DeleteOnRemove( self.floaty )
	local vel = self:GetVelocity():Length()
	local speed = math.Round(vel * 0.09144,0)
	
	if self:WaterLevel() == 1 then	
		self:GetPhysicsObject():AddVelocity(Vector(0,0,5))
		if speed >20 then
			
			self:GetPhysicsObject():AddVelocity(Vector(0,0,10))
		end
	end
end

function ENT:InWater()

	local InWater = self:WaterLevel() > 2

	

	if InWater then

		self.nfwater = self.nfwater or 0

		

		if self.nfwater < CurTime() then

			self.nfwater = CurTime() + 0.02

			local PhysObj = self:GetPhysicsObject()

			if IsValid( PhysObj ) then

				PhysObj:ApplyForceCenter( -self:GetVelocity() * PhysObj:GetMass() * 0.1 )

			end

			self:ApplyAngForce( self:GetAngVel() * PhysObj:GetMass() * 25 )

			

			if self:GetAI() then

				self:Destroy()

			end

			

			if self:GetEngineActive() then

				self:StopEngine()

			end

		end

	end

	

	return InWater

end




function ENT:RunOnSpawn()
	self:GetPhysicsObject():SetBuoyancyRatio( 1 )
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	if nak_color_planes_when_spawned:GetBool() == true then
		local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	
	self:AddPassengerSeat( Vector(0,-11.5,70), Angle(0,-90,12) )
	self:AddPassengerSeat( Vector(-36,39,49), Angle(0,-0,4) )
	self:AddPassengerSeat( Vector(-36,-39,49), Angle(0,-180,4) )
	self.SpawnedFloats = false
	self:SetNWBool("carkeysSupported", true)
	self:SetNWBool("carkeysCustomAlarm", true)
	self:SetNWString("carkeysCAlarmSound", "dodoalarm")
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


function ENT:InitWheels()

	if isnumber( self.WheelMass ) and isnumber( self.WheelRadius ) then

		if isvector( self.WheelPos_L ) then

			local wheel_L = ents.Create( "prop_physics" )

		

			if IsValid( wheel_L ) then

				wheel_L:SetPos( self:LocalToWorld( self.WheelPos_L ) )

				wheel_L:SetAngles( self:LocalToWorldAngles( Angle(0,90,0) ) )

				

				wheel_L:SetModel( "models/props_vehicles/tire001c_car.mdl" )

				wheel_L:Spawn()

				wheel_L:Activate()

				

				wheel_L:SetNoDraw( true )

				wheel_L:DrawShadow( false )

				wheel_L.DoNotDuplicate = true

				

				local radius = self.WheelRadius

				

				wheel_L:PhysicsInitSphere( radius, "jeeptire" )

				wheel_L:SetCollisionBounds( Vector(-radius,-radius,-radius), Vector(radius,radius,radius) )

				

				local LWpObj = wheel_L:GetPhysicsObject()

				if not IsValid( LWpObj ) then

					self:Remove()

					

					print("LFS: Failed to initialize landing gear phys model. Plane terminated.")

					return

				end

			

				LWpObj:EnableMotion(false)

				LWpObj:SetMass( self.WheelMass )

				

				self.wheel_L = wheel_L

				self:DeleteOnRemove( wheel_L )

				self:dOwner( wheel_L )

				

				self:dOwner( constraint.Axis( wheel_L, self, 0, 0, LWpObj:GetMassCenter(), wheel_L:GetPos(), 0, 0, 50, 0, Vector(1,0,0) , false ) )

				self:dOwner( constraint.NoCollide( wheel_L, self, 0, 0 ) )

				

				LWpObj:EnableMotion( true )

				LWpObj:EnableDrag( false ) 

				

			else

				self:Remove()

			

				print("LFS: Failed to initialize landing gear. Plane terminated.")

			end

		end

		

		if isvector( self.WheelPos_R ) then

			local wheel_R = ents.Create( "prop_physics" )

			

			if IsValid( wheel_R ) then

				wheel_R:SetPos( self:LocalToWorld(  self.WheelPos_R ) )

				wheel_R:SetAngles( self:LocalToWorldAngles( Angle(0,90,0) ) )

				

				wheel_R:SetModel( "models/props_vehicles/tire001c_car.mdl" )

				wheel_R:Spawn()

				wheel_R:Activate()

				

				wheel_R:SetNoDraw( true )

				wheel_R:DrawShadow( false )

				wheel_R.DoNotDuplicate = true

				

				local radius = self.WheelRadius

				

				wheel_R:PhysicsInitSphere( radius, "jeeptire" )

				wheel_R:SetCollisionBounds( Vector(-radius,-radius,-radius), Vector(radius,radius,radius) )

				

				local RWpObj = wheel_R:GetPhysicsObject()

				if not IsValid( RWpObj ) then

					self:Remove()

					

					print("LFS: Failed to initialize landing gear phys model. Plane terminated.")

					return

				end

			

				RWpObj:EnableMotion(false)

				RWpObj:SetMass( self.WheelMass )

				

				self.wheel_R = wheel_R

				self:DeleteOnRemove( wheel_R )

				self:dOwner( wheel_R )

				

				self:dOwner( constraint.Axis( wheel_R, self, 0, 0, RWpObj:GetMassCenter(), wheel_R:GetPos(), 0, 0, 50, 0, Vector(1,0,0) , false ) )

				self:dOwner( constraint.NoCollide( wheel_R, self, 0, 0 ) )

				

				RWpObj:EnableMotion( true )

				RWpObj:EnableDrag( false ) 

			else

				self:Remove()

			

				print("LFS: Failed to initialize landing gear. Plane terminated.")

			end

		end
		

		if isvector( self.WheelPos_E ) then

			local SteerMaster2 = ents.Create( "prop_physics" )

			

			if IsValid( SteerMaster2 ) then

				SteerMaster2:SetModel( "models/hunter/plates/plate025x025.mdl" )

				SteerMaster2:SetPos( self:GetPos() )

				SteerMaster2:SetAngles( Angle(0,90,0) )

				SteerMaster2:Spawn()

				SteerMaster2:Activate()

				

				local sm2PObj = SteerMaster2:GetPhysicsObject()

				if IsValid( sm2PObj ) then

					sm2PObj:EnableMotion( false )

				end

				

				SteerMaster2:SetOwner( self )

				SteerMaster2:DrawShadow( false )

				SteerMaster2:SetNotSolid( true )

				SteerMaster2:SetNoDraw( true )

				SteerMaster2.DoNotDuplicate = true

				self:DeleteOnRemove( SteerMaster2 )

				self:dOwner( SteerMaster2 )

				

				self.wheel_E_master = SteerMaster2

				

				local wheel_E = ents.Create( "prop_physics" )

				

				if IsValid( wheel_E ) then

					wheel_E:SetPos( self:LocalToWorld( self.WheelPos_E ) )

					wheel_E:SetAngles( Angle(0,0,0) )

					

					wheel_E:SetModel( "models/props_vehicles/tire001c_car.mdl" )

					wheel_E:Spawn()

					wheel_E:Activate()

					

					wheel_E:SetNoDraw( true )

					wheel_E:DrawShadow( false )

					wheel_E.DoNotDuplicate = true

					

					local radius = self.WheelRadius

					

					wheel_E:PhysicsInitSphere( radius, "jeeptire" )

					wheel_E:SetCollisionBounds( Vector(-radius,-radius,-radius), Vector(radius,radius,radius) )

					

					local EWpObj = wheel_E:GetPhysicsObject()

					if not IsValid( EWpObj ) then

						self:Remove()

						

						print("LFS: Failed to initialize landing gear phys model. Plane terminated.")

						return

					end

				

					EWpObj:EnableMotion(false)

					EWpObj:SetMass( self.WheelMass )

					

					self.wheel_E = wheel_E

					self:DeleteOnRemove( wheel_E )

					self:dOwner( wheel_E )

					

					self:dOwner( constraint.AdvBallsocket(wheel_E, SteerMaster2,0,0,Vector(0,0,0),Vector(0,0,0),0,0, -180, -0.01, -0.01, 180, 0.01, 0.01, 0, 0, 0, 1, 0) )

					self:dOwner( constraint.AdvBallsocket(wheel_E,self,0,0,Vector(0,0,0),Vector(0,0,0),0,0, -180, -180, -180, 180, 180, 180, 0, 0, 0, 0, 0) )

					self:dOwner( constraint.NoCollide( wheel_E, self, 0, 0 ) )

					

					EWpObj:EnableMotion( true )

					EWpObj:EnableDrag( false ) 

				end

			end

		end
		

		if isvector( self.WheelPos_C ) then

			local SteerMaster = ents.Create( "prop_physics" )

			

			if IsValid( SteerMaster ) then

				SteerMaster:SetModel( "models/hunter/plates/plate025x025.mdl" )

				SteerMaster:SetPos( self:GetPos() )

				SteerMaster:SetAngles( Angle(0,90,0) )

				SteerMaster:Spawn()

				SteerMaster:Activate()

				

				local smPObj = SteerMaster:GetPhysicsObject()

				if IsValid( smPObj ) then

					smPObj:EnableMotion( false )

				end

				

				SteerMaster:SetOwner( self )

				SteerMaster:DrawShadow( false )

				SteerMaster:SetNotSolid( true )

				SteerMaster:SetNoDraw( true )

				SteerMaster.DoNotDuplicate = true

				self:DeleteOnRemove( SteerMaster )

				self:dOwner( SteerMaster )

				

				self.wheel_C_master = SteerMaster

				

				local wheel_C = ents.Create( "prop_physics" )

				

				if IsValid( wheel_C ) then

					wheel_C:SetPos( self:LocalToWorld( self.WheelPos_C ) )

					wheel_C:SetAngles( Angle(0,0,0) )

					

					wheel_C:SetModel( "models/props_vehicles/tire001c_car.mdl" )

					wheel_C:Spawn()

					wheel_C:Activate()

					

					wheel_C:SetNoDraw( true )

					wheel_C:DrawShadow( false )

					wheel_C.DoNotDuplicate = true

					

					local radius = self.WheelRadius

					

					wheel_C:PhysicsInitSphere( radius, "jeeptire" )

					wheel_C:SetCollisionBounds( Vector(-radius,-radius,-radius), Vector(radius,radius,radius) )

					

					local CWpObj = wheel_C:GetPhysicsObject()

					if not IsValid( CWpObj ) then

						self:Remove()

						

						print("LFS: Failed to initialize landing gear phys model. Plane terminated.")

						return

					end

				

					CWpObj:EnableMotion(false)

					CWpObj:SetMass( self.WheelMass )

					

					self.wheel_C = wheel_C

					self:DeleteOnRemove( wheel_C )

					self:dOwner( wheel_C )

					

					self:dOwner( constraint.AdvBallsocket(wheel_C, SteerMaster,0,0,Vector(0,0,0),Vector(0,0,0),0,0, -180, -0.01, -0.01, 180, 0.01, 0.01, 0, 0, 0, 1, 0) )

					self:dOwner( constraint.AdvBallsocket(wheel_C,self,0,0,Vector(0,0,0),Vector(0,0,0),0,0, -180, -180, -180, 180, 180, 180, 0, 0, 0, 0, 0) )

					self:dOwner( constraint.NoCollide( wheel_C, self, 0, 0 ) )

					

					CWpObj:EnableMotion( true )

					CWpObj:EnableDrag( false ) 

				end

			end

		end

	end

	

	local PObj = self:GetPhysicsObject()

	

	if IsValid( PObj ) then 

		PObj:EnableMotion( true )

	end

	

	self:PhysWake() 

end


function ENT:HandleLandingGear()

	local Driver = self:GetDriver()

	

	if IsValid( Driver ) then

		local KeyJump = Driver:lfsGetInput( "VSPEC" )

		

		if self.OldKeyJump ~= KeyJump then

			self.OldKeyJump = KeyJump

			if KeyJump then

				self:ToggleLandingGear()

				self:PhysWake()

			end

		end

	end

	

	local TValAuto = (self:GetStability() > 0.3) and 0 or 1

	local TValManual = self.LandingGearUp and 0 or 1

	

	local TVal = self.WheelAutoRetract and TValAuto or TValManual

	local Speed = FrameTime()

	local Speed2 = Speed * math.abs( math.cos( math.rad( self:GetLGear() * 180 ) ) )

	

	self:SetLGear( self:GetLGear() + math.Clamp(TVal - self:GetLGear(),-Speed,Speed) )

	self:SetRGear( self:GetRGear() + math.Clamp(TVal - self:GetRGear(),-Speed2,Speed2) )

	

	if IsValid( self.wheel_R ) then

		local RWpObj = self.wheel_R:GetPhysicsObject()

		if IsValid( RWpObj ) then

			RWpObj:SetMass( 1 + (self.WheelMass - 1) * self:GetRGear() ^ 5 )

		end

	end

	

	if IsValid( self.wheel_L ) then

		local LWpObj = self.wheel_L:GetPhysicsObject()

		if IsValid( LWpObj ) then

			LWpObj:SetMass( 1 + (self.WheelMass - 1) * self:GetLGear() ^ 5 )

		end

	end

	

	if IsValid( self.wheel_C ) then

		local CWpObj = self.wheel_C:GetPhysicsObject()

		if IsValid( CWpObj ) then

			CWpObj:SetMass( 1 + (self.WheelMass - 1) * self:GetRGear() )

		end

	end

	if IsValid( self.wheel_E ) then

		local CWpObj = self.wheel_E:GetPhysicsObject()

		if IsValid( CWpObj ) then

			CWpObj:SetMass( 1 + (self.WheelMass - 1) * self:GetRGear() )

		end

	end

end


function ENT:SteerWheel( SteerAngle )
	if IsValid( self.wheel_C_master ) and IsValid( self.wheel_E_master ) then
		if isvector( self.WheelPos_L ) and isvector( self.WheelPos_R ) and isvector( self.WheelPos_C ) and isvector( self.WheelPos_E ) then
			local SteerMaster = self.wheel_C_master
			local SteerMaster2 = self.wheel_E_master
			local smPObj = SteerMaster:GetPhysicsObject()
			local sm2PObj = SteerMaster2:GetPhysicsObject()
			if IsValid( smPObj ) then
				if smPObj:IsMotionEnabled() then
					smPObj:EnableMotion( false )
				end
			end
			if IsValid( sm2PObj ) then
				if sm2PObj:IsMotionEnabled() then
					sm2PObj:EnableMotion( false )
				end
			end
			local Mirror = ((self.WheelPos_L.x + self.WheelPos_R.x) * 0.5 > self.WheelPos_C.x) and -1 or 1
			local Mirror2 = ((self.WheelPos_L.x + self.WheelPos_R.x) * 0.5 > self.WheelPos_E.x) and -1 or 1
			self.wheel_C_master:SetAngles( self:LocalToWorldAngles( Angle(0,math.Clamp(SteerAngle * Mirror,-45,45),0) ) )
			self.wheel_E_master:SetAngles( self:LocalToWorldAngles( Angle(0,math.Clamp(SteerAngle * Mirror2,-45,45),0) ) )
		end
	end
end