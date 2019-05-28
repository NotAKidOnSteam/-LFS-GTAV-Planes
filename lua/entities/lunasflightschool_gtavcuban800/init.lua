--DO NOT EDIT OR REUPLOAD THIS FILE

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")


function ENT:SpawnFunction( ply, tr, ClassName )

	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal * 120 + Vector(0,0,-120))
	ent:Spawn()
	ent:Activate()

	return ent
end



function ENT:RunOnSpawn()
	self.timerreset = false 
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	if nak_color_planes_when_spawned:GetBool() == true then
		local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	
	self:AddPassengerSeat( Vector(45,-11,61), Angle(0,-90,10) )
	timer.Simple(1, function() if self:IsValid() then
	if self:GetAI() then
		self:SetAmmoSecondary(math.random( 0,4,1 ))
	end
	end end)
end





function ENT:OnTick()
	local hp = self:GetHP()
	local maxhp = self:GetMaxHP()
	local rando = math.random(10,20,1)
	if maxhp/2 > hp and self:IsValid() then
	
		if not self.timerreset == true and self:IsValid() then
			self.timerreset = true
			timer.Simple( math.random(10,20,1), function() if self:IsValid() then
			
				self:GetPhysicsObject():SetDragCoefficient( self.Drag + 0.05 ) 
				self:StopEngine()
				print("oof")
				if self:GetAI() then
					timer.Simple( math.random(2,6,1), function() if self:IsValid() then
					self:StartEngine() 
					print("on")
					self.timerreset = false
					end end)
				else
					self.timerreset = false
					print("on not ai")
				end
			end end)
			
		end
	end
end


function ENT:Explode()
	if self.ExplodedAlready then return end

	self.ExplodedAlready = true

	local Driver = self:GetDriver()
	local Gunner = self:GetGunner()
	if IsValid( Driver ) then
		Driver:TakeDamage( Driver:Health(), self.FinalAttacker or Entity(0), self.FinalInflictor or Entity(0) )
	end

	if IsValid( Gunner ) then
		Gunner:TakeDamage( Gunner:Health(), self.FinalAttacker or Entity(0), self.FinalInflictor or Entity(0) )
	end
	
	if istable( self.pSeats ) then
		for _, pSeat in pairs( self.pSeats ) do

			if IsValid( pSeat ) then
				local psgr = pSeat:GetDriver()
				if IsValid( psgr ) then
					psgr:TakeDamage( psgr:Health(), self.FinalAttacker or Entity(0), self.FinalInflictor or Entity(0) )
				end
			end
		end
	end

	local ent = ents.Create( "lunasflightschool_destruction" )
	if IsValid( ent ) then
		ent:SetPos( self:LocalToWorld( self:OBBCenter() ) )

		ent.GibModels = self.GibModels

		ent:Spawn()
		ent:Activate()

	end
	nak_overpowered = GetConVar( "nak_overpowered_bombs" )
	local weaponselection = self:GetAmmoSecondary()
	
	if nak_overpowered:GetBool() == true then
		if weaponselection == 0 then
			local ent = ents.Create( "gb_bomb_1000gp" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
			
		end
		if weaponselection == 1 then
			local ent = ents.Create( "gb_bomb_mk77" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
	
		end
		if weaponselection == 2 then

			local ent = ents.Create( "gb_bomb_500gp" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true

		end
		if weaponselection == 3 then
			local ent = ents.Create( "gb_bomb_cbu" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
			
		end
	else
		if weaponselection == 0 then
			local ent = ents.Create( "gb_bomb_250gp" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
		end
		
		if weaponselection == 1 then
			local ent = ents.Create( "gb_bomb_fab250" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
		end
		if weaponselection == 2 then

			local ent = ents.Create( "gb_bomb_sc500" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
		end
		if weaponselection == 3 then
			local ent = ents.Create( "gb_bomb_cbu" )
			local Pos = self:LocalToWorld( Vector(50,0,-30) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
		end
	end

	self:Remove()
end

function ENT:Destroy()
	self.Destroyed = true
	local PObj = self:GetPhysicsObject()
	if IsValid( PObj ) then
		PObj:SetDragCoefficient(self.Drag - 4)
	end
end




function ENT:PrimaryAttack()
	nak_overpowered = GetConVar( "nak_overpowered_bombs" )
	if not self:CanPrimaryAttack() then return end
	if not (file.Exists( "models/gredwitch/bombs/sc100.mdl", "GAME" )) then return end
	
	local tr = util.TraceLine({
	start = self:GetPhysicsObject():GetPos(),
	endpos = self:GetPhysicsObject():GetPos() - Vector(0, 0, 35000),
	filter = self,
	})
	local groundpos = tr.HitPos
	local distancegroundcar = self:GetPhysicsObject():GetPos():Distance( tr.HitPos )
	local plzwork = distancegroundcar <250
	if plzwork then
		self:SetNWBool("onground", false)
	else
		self:SetNWBool("onground", true)
	end

	if not self:GetNWBool("onground") == true then return end
	
	local weaponselection = self:GetAmmoSecondary()
	
	
	if nak_overpowered:GetBool() == true then

		if weaponselection == 0 then

			

			self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
			self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
			
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_1000gp" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 15 )
						timer.Simple(15, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
				
			end
			if weaponselection == 1 then

				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_mk77" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 15 )
						timer.Simple(15, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
			end
			if weaponselection == 2 then

				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_500gp" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 8 )
						timer.Simple(8, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
			end
			if weaponselection == 3 then

				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_cbu" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 8 )
						timer.Simple(8, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
			end
			if weaponselection == 4 then
			
				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				timer.Simple(1.5, function()
				if self:IsValid() then
					self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
					self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
					self:EmitSound( "lfs/bf109/gear.wav" )
				end
				end)
			end
		else -----------------------------------------------------------------------------------------------------------------

			if weaponselection == 0 then
			
				
			
				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_250gp" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 2.5 )
						timer.Simple(2.5, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
				
			end
			if weaponselection == 1 then
			
				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_fab250" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 2.5 )
						timer.Simple(2.5, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
			end
			if weaponselection == 2 then
			
				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_sc500" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 4 )
						timer.Simple(4, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
			end
			if weaponselection == 3 then
			
				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				if self:GetNWBool("shooting") == false then
					self:SetNWBool("shooting", true)
					timer.Simple(1, function()
					if self:IsValid() then
						local ent = ents.Create( "gb_bomb_cbu" )
						local Pos = self:LocalToWorld( Vector(50,0,-30) )
						ent:SetPos( Pos )
						ent:SetAngles( self:GetAngles() )
						ent:Spawn()
						ent:Activate()
						local speed = self:GetVelocity()
						ent:GetPhysicsObject():SetMass(1000)
						ent:GetPhysicsObject():AddVelocity(speed)
						ent:SetPhysicsAttacker(self:GetDriver())
						ent.Armed = true
						self:SetNextPrimary( 8 )
						timer.Simple(8, function() if self:IsValid() then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
						self:TakePrimaryAmmo()
					end
					end)
					timer.Simple(1.5, function()
					if self:IsValid() then
						self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
						self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
						self:SetNWBool("shooting", false)
						self:EmitSound( "lfs/bf109/gear.wav" )
					end
					end)
				end
			end
			
			if weaponselection == 4 then
			
				self:ManipulateBoneAngles( 11, Angle( -90,0,0  ) )
				self:ManipulateBoneAngles( 10, Angle( 90,0,0  ) )
				
				timer.Simple(1.5, function()
				if self:IsValid() then
					self:ManipulateBoneAngles( 11, Angle( 0,0,0  ) )
					self:ManipulateBoneAngles( 10, Angle( 0,0,0 ) )
					self:EmitSound( "lfs/bf109/gear.wav" )
				end
				end)
			end
	end
end

function ENT:CreateAI()

	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )

	local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}

	self:SetAmmoSecondary(math.random( 0,4,1 ))
	if nak_color_planes_when_spawned:GetBool() == false then
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	

end

function ENT:RemoveAI()
end



function ENT:HandleWeapons(Fire1, Fire2)
	if not self:CanPrimaryAttack() then return end
	local Driver = self:GetDriver()
	
	if IsValid( Driver ) then
		if self:GetAmmoPrimary() > 0 and self:GetAmmoSecondary() < 4 or self:GetAmmoSecondary() == 0 then
			Fire1 = Driver:KeyDown( IN_ATTACK )
		end
	end
	
	if Fire1 then
		self:PrimaryAttack()
	end
	
	if self.OldFire ~= Fire1 then
		
		if Fire1 then
			self.wpn1 = CreateSound( self, "lfs/bf109/start.wav" )
			self.wpn1:Play()
			self:CallOnRemove( "stopmesounds1", function( self )
				if self.wpn1 then
					self.wpn1:Stop()
				end
			end)
		else
			if self.OldFire == true then
				if self.wpn1 then
					self.wpn1:Stop()
				end
				self.wpn1 = nil
					
				
			end
		end
		
		self.OldFire = Fire1
	end
end


function ENT:PrepExplode()

	if self.MarkForDestruction then

		self:Explode()

	end

	

	if self:IsDestroyed() then

		if self:GetVelocity():Length() < 100 then

			self:Explode()

		end

	end

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
