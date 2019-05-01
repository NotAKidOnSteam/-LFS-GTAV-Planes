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
	
	ent.floaty = ents.Create("prop_physics")
	ent.floaty:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty:SetPos(ent:GetPos() + ent:GetForward() * -120 + ent:GetRight() * 60 + ent:GetUp() * 40   )
	ent.floaty:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty:Spawn()
	ent.floaty:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty, 0, 0, 0, true )
	ent.floaty:Activate()
	ent.floaty:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	ent.floaty2 = ents.Create("prop_physics")
	ent.floaty2:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty2:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty2:SetPos(ent:GetPos() + ent:GetForward() * -120 + ent:GetRight() * -60 + ent:GetUp() * 40   )
	ent.floaty2:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty2:Spawn()
	ent.floaty2:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty2, 0, 0, 0, true )
	ent.floaty2:Activate()
	ent.floaty2:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty2:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	ent.floaty3 = ents.Create("prop_physics")
	ent.floaty3:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty3:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty3:SetPos(ent:GetPos() + ent:GetForward() * -60 + ent:GetRight() * 60 + ent:GetUp() * 40   )
	ent.floaty3:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty3:Spawn()
	ent.floaty3:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty3, 0, 0, 0, true )
	ent.floaty3:Activate()
	ent.floaty3:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty3:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	ent.floaty4 = ents.Create("prop_physics")
	ent.floaty4:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty4:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty4:SetPos(ent:GetPos() + ent:GetForward() * -60 + ent:GetRight() * -60 + ent:GetUp() * 40   )
	ent.floaty4:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty4:Spawn()
	ent.floaty4:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty4, 0, 0, 0, true )
	ent.floaty4:Activate()
	ent.floaty4:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty4:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	ent.floaty5 = ents.Create("prop_physics")
	ent.floaty5:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty5:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty5:SetPos(ent:GetPos() + ent:GetForward() * -0 + ent:GetRight() * 60 + ent:GetUp() * 40   )
	ent.floaty5:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty5:Spawn()
	ent.floaty5:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty5, 0, 0, 0, true )
	ent.floaty5:Activate()
	ent.floaty5:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty5:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	ent.floaty6 = ents.Create("prop_physics")
	ent.floaty6:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty6:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty6:SetPos(ent:GetPos() + ent:GetForward() * -0 + ent:GetRight() * -60 + ent:GetUp() * 40   )
	ent.floaty6:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty6:Spawn()
	ent.floaty6:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty6, 0, 0, 0, true )
	ent.floaty6:Activate()
	ent.floaty6:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty6:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	ent.floaty7 = ents.Create("prop_physics")
	ent.floaty7:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty7:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty7:SetPos(ent:GetPos() + ent:GetForward() * 60 + ent:GetRight() * 60 + ent:GetUp() * 40   )
	ent.floaty7:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty7:Spawn()
	ent.floaty7:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty7, 0, 0, 0, true )
	ent.floaty7:Activate()
	ent.floaty7:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty7:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	ent.floaty8 = ents.Create("prop_physics")
	ent.floaty8:SetCollisionGroup(COLLISION_GROUP_NONE)	
	ent.floaty8:SetModel("models/props_c17/oildrum001.mdl")
	ent.floaty8:SetPos(ent:GetPos() + ent:GetForward() * 60 + ent:GetRight() * -60 + ent:GetUp() * 40  )
	ent.floaty8:SetAngles(Angle(90,ent:GetAngles(),ent:GetAngles()))
	ent.floaty8:Spawn()
	ent.floaty8:GetPhysicsObject():SetMass(10)
	constraint.Weld( ent, ent.floaty8, 0, 0, 0, true )
	ent.floaty8:Activate()
	ent.floaty8:GetPhysicsObject():SetDragCoefficient(-9000000)
	ent.floaty8:GetPhysicsObject():SetBuoyancyRatio( 10 )
	
	constraint.NoCollide( ent.floaty8, ent, 0, 0, true )
	constraint.NoCollide( ent.floaty7, ent, 0, 0, true )
	constraint.NoCollide( ent.floaty6, ent, 0, 0, true )
	constraint.NoCollide( ent.floaty5, ent, 0, 0, true )
	constraint.NoCollide( ent.floaty4, ent, 0, 0, true )
	constraint.NoCollide( ent.floaty3, ent, 0, 0, true )
	constraint.NoCollide( ent.floaty2, ent, 0, 0, true )
	constraint.NoCollide( ent.floaty, ent, 0, 0, true )
	
	
	ent.floaty:SetColor( 255, 255, 255, 0 )
	ent.floaty:SetNoDraw( true)
	ent.floaty2:SetColor( 255, 255, 255, 0 )
	ent.floaty2:SetNoDraw( true)
	ent.floaty3:SetColor( 255, 255, 255, 0 )
	ent.floaty3:SetNoDraw( true)
	ent.floaty4:SetColor( 255, 255, 255, 0 )
	ent.floaty4:SetNoDraw( true)
	ent.floaty5:SetColor( 255, 255, 255, 0 )
	ent.floaty5:SetNoDraw( true)
	ent.floaty6:SetColor( 255, 255, 255, 0 )
	ent.floaty6:SetNoDraw( true)
	ent.floaty7:SetColor( 255, 255, 255, 0 )
	ent.floaty7:SetNoDraw( true)
	ent.floaty8:SetColor( 255, 255, 255, 0 )
	ent.floaty8:SetNoDraw( true)
	--]]
	return ent
end

function ENT:OnTick(ent)
	self:CallOnRemove( "removebarrelssonolagbuildupfromvodo", function( ent )
		if self.floaty8:IsValid() then self.floaty8:Remove() end 
		if self.floaty7:IsValid() then self.floaty7:Remove() end 
		if self.floaty6:IsValid() then self.floaty6:Remove() end 
		if self.floaty5:IsValid() then self.floaty5:Remove() end 
		if self.floaty4:IsValid() then self.floaty4:Remove() end 
		if self.floaty3:IsValid() then self.floaty3:Remove() end 
		if self.floaty2:IsValid() then self.floaty2:Remove() end 
		if self.floaty:IsValid() then self.floaty:Remove() end 
	end )
	
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

				

				wheel_L:SetNoDraw( true)

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

				

				wheel_R:SetNoDraw( true)

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

			local wheel_E = ents.Create( "prop_physics" )

		

			if IsValid( wheel_E ) then

				wheel_E:SetPos( self:LocalToWorld( self.WheelPos_E ) )

				wheel_E:SetAngles( self:LocalToWorldAngles( Angle(0,90,0) ) )

				

				wheel_E:SetModel( "models/props_vehicles/tire001c_car.mdl" )

				wheel_E:Spawn()

				wheel_E:Activate()

				

				wheel_E:SetNoDraw( true)

				wheel_E:DrawShadow( false )

				wheel_E.DoNotDuplicate = true

				

				local radius = self.WheelRadius

				

				wheel_E:PhysicsInitSphere( radius, "jeeptire" )

				wheel_E:SetCollisionBounds( Vector(-radius,-radius,-radius), Vector(radius,radius,radius) )

				

				local LWpObj = wheel_E:GetPhysicsObject()

				if not IsValid( LWpObj ) then

					self:Remove()

					

					print("LFS: Failed to initialize landing gear phys model. Plane terminated.")

					return

				end

			

				LWpObj:EnableMotion(false)

				LWpObj:SetMass( self.WheelMass )

				

				self.wheel_E = wheel_E

				self:DeleteOnRemove( wheel_E )

				self:dOwner( wheel_E )

				

				self:dOwner( constraint.Axis( wheel_E, self, 0, 0, LWpObj:GetMassCenter(), wheel_E:GetPos(), 0, 0, 50, 0, Vector(1,0,0) , false ) )

				self:dOwner( constraint.NoCollide( wheel_E, self, 0, 0 ) )

				

				LWpObj:EnableMotion( true )

				LWpObj:EnableDrag( false ) 

				

			else

				self:Remove()

			

				print("LFS: Failed to initialize landing gear. Plane terminated.")

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

				SteerMaster:SetNoDraw( true)

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

					

					wheel_C:SetNoDraw( true)

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

