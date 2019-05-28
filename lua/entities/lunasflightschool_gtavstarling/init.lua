--DO NOT EDIT OR REUPLOAD THIS FILE

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName )

	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal * 90 + Vector(0,0,-120))
	ent:Spawn()
	ent:Activate()
	

	return ent
end


function ENT:SecondaryAttack()
	nak_ai_dont_use_missles = GetConVar( "nak_ai_dont_use_missles" )
	if self:GetAI() and nak_ai_dont_use_missles:GetBool() == false then return end
	
	if not self:CanSecondaryAttack() then return end

	if self:GetAI() then
	self:SetNextSecondary( 1 )
	else
	self:SetNextSecondary( 0.2 )
	end

	self:TakeSecondaryAmmo()

	if istable( self.MissileEnts ) then

		local Missile = self.MissileEnts[ self:GetAmmoSecondary() + 1 ]
		Missile:EmitSound( "npc/waste_scanner/grenade_fire.wav" )

		if IsValid( Missile ) then

			local ent = ents.Create( "lunasflightschool_missile" )
			
			local mPos = Missile:GetPos()

			local Ang = self:WorldToLocal( mPos ).y > 0 and -1 or 1
			ent:SetColor(self:GetColor())
			ent:SetPos( mPos )

			ent:SetAngles( self:LocalToWorldAngles( Angle(0,Ang,0) ) )
			
			ent:Spawn()

			ent:Activate()
			
			ent:SetAttacker( self:GetDriver() )

			ent:SetInflictor( self )

			ent:SetStartVelocity( self:GetVelocity():Length() )

			constraint.NoCollide( ent, self, 0, 0 ) 
			if IsValid( self.wheel_R ) then
				constraint.NoCollide( ent, self.wheel_R, 0, 0 ) 
			end
			if IsValid( self.wheel_L ) then
				constraint.NoCollide( ent, self.wheel_L, 0, 0 ) 
			end
			if IsValid( self.wheel_C ) then
				constraint.NoCollide( ent, self.wheel_C, 0, 0 ) 
			end
		end
	end
end

function ENT:OnTick()
	
	
	if self:GetBodygroup( 2 ) == 0 then
		self:SetAmmoSecondary(0)
		if self.twice == true then
			self.twice = false
		end
	elseif self:GetBodygroup( 2 ) == 1 then
		if self.twice == false then
			self:SetAmmoSecondary(6)
			self.twice = true
		end
	end
	
	nak_ai_infinite_missles = GetConVar( "nak_ai_infinite_missles" )
	nak_infinite_missles = GetConVar( "nak_infinite_missles" )
	if nak_infinite_missles:GetBool() == true or nak_ai_infinite_missles:GetBool() == true then
	
		if self:GetAmmoSecondary() == 0 and self:GetNWBool("NoMisslesLeft") == true then
		
			self:SetNWBool("NoMisslesLeft", false)
			timer.Simple(5, function()
				if self:IsValid() and self.twice == true and self:GetAmmoSecondary() <1 then
				
					self:SetAmmoSecondary(6)
					self:EmitSound( "lfs/bf109/gear.wav" )
				end
			end)	
		elseif self:GetAmmoSecondary() >0 then
			self:SetNWBool("NoMisslesLeft", true)
		end
	end
end




function ENT:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end



	self:SetNextPrimary( 0.05 )

	

	local fP = {

		Vector(29,-54,96),

		Vector(29,54,96),

	}



	self.NumPrim = self.NumPrim and self.NumPrim + 1 or 1

	if self.NumPrim > 2 then self.NumPrim = 1 end

	

	local bullet = {}

	bullet.Num 	= 1

	bullet.Src 	= self:LocalToWorld( fP[self.NumPrim] )

	bullet.Dir 	= self:LocalToWorldAngles( Angle(-1,(fP[self.NumPrim].y > 0 and -0.5 or 0.5),0) ):Forward()

	bullet.Spread 	= Vector( 0.015,  0.015, 0 )

	bullet.Tracer	= 1

	bullet.TracerName	= "lfs_tracer_green"

	bullet.Force	= 100

	bullet.HullSize 	= 10

	bullet.Damage	= 32

	bullet.Attacker 	= self:GetDriver()

	bullet.AmmoType = "Pistol"

	bullet.Callback = function(att, tr, dmginfo)

		dmginfo:SetDamageType(DMG_AIRBOAT)

	end

	self:FireBullets( bullet )

	

	self:TakePrimaryAmmo( 2 )

end




function ENT:RunOnSpawn()
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	if nak_color_planes_when_spawned:GetBool() == true then
		local colorSelect = { Color(182, 182, 182, 255), Color(72, 72, 72, 255), Color(0, 127, 127, 255), Color(127, 111, 63, 255), Color(95, 127, 63, 255)}
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	
	self:SetNWBool("NoMisslesLeft", false)

	self.MissileEnts = {}

	for k,v in pairs( self.MISSILES ) do

		for _,n in pairs( v ) do

			local Missile = ents.Create( "prop_dynamic" )

			Missile:SetModel( self.MISSILEMDL )

			Missile:SetPos( self:LocalToWorld( n ) )

			Missile:SetAngles( self:GetAngles() )

			Missile:SetMoveType( MOVETYPE_NONE )

			Missile:Spawn()

			Missile:Activate()

			Missile:SetNotSolid( true )

			Missile:DrawShadow( false )

			Missile:SetParent( self )

			Missile.DoNotDuplicate = true

			self:dOwner( Missile )
			table.insert( self.MissileEnts, Missile )
		end
	end
	self.twice = false
end



function ENT:CreateAI()
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}

	if nak_color_planes_when_spawned:GetBool() == false then
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	

end

function ENT:RemoveAI()
end


function ENT:HandleWeapons(Fire1, Fire2)

	local Driver = self:GetDriver()

	if IsValid( Driver ) then
		if self:GetAmmoPrimary() > 0 then
			Fire1 = Driver:KeyDown( IN_ATTACK )
		end
		if self:GetAmmoSecondary() > 0 then
			Fire2 = Driver:KeyDown( IN_ATTACK2 )
		end
	end
	if Fire1 then
		self:PrimaryAttack()
	end
	
	if istable( self.MissileEnts ) then
		for k, v in pairs( self.MissileEnts ) do
			if IsValid( v ) then
				if k > self:GetAmmoSecondary() then
					v:SetNoDraw( true )
				else
					v:SetNoDraw( false )
				end
			end
		end
	end

	if self.OldFire2 ~= Fire2 then
		if Fire2 then
			self:SecondaryAttack()
		end
		self.OldFire2 = Fire2
	end
	if self.OldFire ~= Fire1 then
		if Fire1 then
			self.wpn1 = CreateSound( self, "SPITFIRE_FIRE_LOOP" )
			self.wpn1:Play()
			self:CallOnRemove( "stopmesounds12", function( ent )
				if ent.wpn1 then
					ent.wpn1:Stop()
				end
			end)
		else
			if self.OldFire == true then
				if self.wpn1 then
					self.wpn1:Stop()
				end
				self.wpn1 = nil
				self:EmitSound( "SPITFIRE_FIRE_LASTSHOT" )
			end
		end
		self.OldFire = Fire1
	end
end


function ENT:OnEngineStarted()
	self:EmitSound( "JET_START.ogg" )
end

function ENT:OnEngineStopped()
	self:EmitSound( "JET_SHUTOFF.ogg" )
end


function ENT:HandleLandingGear()
	--loool nub r you looking for why this plane doesnt have retractable landing gear? WEHLP BLAME ROCKSTAR BECAUSE IT IS NOT IN GTAV.
	--idk i could have added it but less rigging work in blender = less boring more time to be in gmod and code :P
	--This function has to be empty so the wheels dont change when space is pressed
end


function ENT:DropBombs()
	print("boom")
end







function ENT:OnReloadWeapon()
	self:SetAmmoPrimary( self:GetMaxAmmoPrimary() )
	self:SetAmmoSecondary( self:GetMaxAmmoSecondary() )
	self:SetBombsAmmo( self:GetMaxBombsAmmo() ) -- ADDED THIS TO DEFAULT RELOAD FUNCTION SO IT ALSO RELOADS BOMBS
end
--NetworkVar doesnt make "take" a thing so we make it manually. SET AND GET IN "SetBombsAmmo" and "GetBombsAmmo" is created when using !self:NetworkVar! (look lines 190-191 in shared.lua) that is the part that makes the C menu properties. Configure the order, name, min, and max there!
function ENT:TakeBombsAmmo( amount )
	amount = amount or 1
	self:SetBombsAmmo( math.max(self:GetBombsAmmo() - amount,0) )
end