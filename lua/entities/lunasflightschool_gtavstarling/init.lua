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
	if self:GetAI() and nak_ai_dont_use_missles:GetInt() == 1 then return end
	
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
	local tr = util.TraceLine({
	start = self:LocalToWorld( Vector(0,0,200) ),
	endpos = self:LocalToWorld( Vector(0,0,-34000) ),
	filter = self,
	})
	local groundpos = tr.HitPos
	local groundpos = self:GetPhysicsObject():GetPos():Distance( tr.HitPos )
	if groundpos<1000 then
		self.NearGround = true
	elseif groundpos>1000 then
		self.NearGround = false
	end

	-- check if plane has player inside, is not ai, then if my custom key is pressed defined in line 106 of nak_gtav_planes.lua (defining it with the lfskeyadd thing makes the key changable in the lfs control C menu)
	if self:GetActive() and not self:GetAI() then
		local IsMyKeyPressed = self:GetDriver():lfsGetInput( "BOMB_DROP" )

		if IsMyKeyPressed == true then
			self.KeyPressed  = self.KeyPressed + 1
		elseif IsMyKeyPressed == false then
			if self.KeyPressed > 11 and self:GetBayOpen() ~= 1 and self.NearGround == false then
				--drop bomb
				self:DropBombs()
			elseif self.KeyPressed > 2 and self.KeyPressed < 10 then 
				--open bay door
				self:OpenHatch()	
			end
			self.KeyPressed = 0 
		end
	end

	-- this code below is checking if the bodygroup for the missles are set, and if so give it ammo once
	if self:GetBodygroup( 2 ) == 0 then
		self:SetAmmoSecondary(-1)
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
	if not self:GetAI() and nak_infinite_missles:GetInt() == 1 or self:GetAI() and nak_ai_infinite_missles:GetInt() == 1 then
	
		if self:GetAmmoSecondary() == 0 and self:GetNWBool("NoMisslesLeft") == true then
		
			self:SetNWBool("NoMisslesLeft", false)
			timer.Simple(5, function()
				if self:IsValid() then
				
					self:SetAmmoSecondary(6)
					self:EmitSound( "lfs/bf109/gear.wav" )
				end
			end)	
		elseif self:GetAmmoSecondary() >0 then
			self:SetNWBool("NoMisslesLeft", true)
		end
	end
	-- boost
	local Driver = self:GetDriver()
	if IsValid( Driver ) and self:GetBodygroup( 3 ) == 1 and not self:GetAI() then
		local KeyJump = Driver:lfsGetInput( "VSPEC" )
		if self.OldKeyJump ~= KeyJump then
			self.OldKeyJump = KeyJump
			if KeyJump and self:GetEngineActive() and self:GetBoosting() == false and self:GetLockBoost() == false then
				self:SetBoosting(true)
				self.BoostEnd = false
				self.BoostStart = true
			elseif self:GetLockBoost() == true then
				self:SetBoosting(false)
				self.BoostStart = false
				self.BoostEnd = true
			else 
				self.BoostEnd = true
				self.BoostStart = false
				self:SetBoosting(false)
			end
		end
	elseif self:GetAI() and self:GetBodygroup(3) == 1 then
		local KeyJump = self.AIDamaged
		if self.OldKeyJump ~= KeyJump then
			self.OldKeyJump = KeyJump
			if KeyJump and self:GetEngineActive() and self:GetBoosting() == false and self:GetLockBoost() == false then
				self:SetBoosting(true)
				self.BoostEnd = false
				self.BoostStart = true
			elseif self:GetLockBoost() == true then
				self:SetBoosting(false)
				self.BoostStart = false
				self.BoostEnd = true
			else 
				self.BoostEnd = true
				self.BoostStart = false
				self:SetBoosting(false)
			end
		end
	end	
	local forward = self:EyeAngles():Forward()
	if self:GetBodygroup( 3 ) == 1 and self:GetBoosting() == true then

		if self:GetBoost() < 1 then
			self:SetLockBoost(true)
			self:SetBoosting(false)
		elseif self:GetBoost() > 0 then
			if self.BoostStart == true then
				self.BoostStart = false
				self:EmitSound("GTAV_BOOST_START")
			end
			self:SetBoost(self:GetBoost() - 1)
			self:GetPhysicsObject():AddVelocity(forward*10)
		end
	elseif self:GetLockBoost() == true then
		self:SetBoost(self:GetBoost() + 0.5)
		if self.BoostEnd == false then
			self:StopSound("GTAV_BOOST_START") 
			self.BoostEnd = true
			self:EmitSound("GTAV_BOOST_END")
		end
		if self:GetBoost() >= 799.5 then
			self:SetLockBoost(false)
			self.BoostEnd = false
		end
	elseif self:GetBoost() <= 799.5 then
		if self.BoostEnd == true then
			self:StopSound("GTAV_BOOST_START") 
			self.BoostEnd = false
			self:EmitSound("GTAV_BOOST_END")
		end
			
		self:SetBoost(self:GetBoost() + 0.5)
	end
	-- bomb door
	if self.OpenClose == 0 then
		self:SetBayOpen(0)
	elseif self.OpenClose == 1 then
		self:SetBayOpen(1)
	end
end


function ENT:PrimaryAttack()
	if self:GetAI() then
		self:OpenHatch()	
		self:DropBombs()
		self:OpenHatch()	
	end
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

	bullet.Force	= 90

	bullet.HullSize 	= 8

	bullet.Damage	= 12

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
	self:SetNWBool("CanBombAttack", false)
	self.KeyPressed = 0
	self.OpenClose = 1
	self.AIDamagedExtend = 0
	self:SetBoost(800)
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
	
	self:SetNWBool("carkeysSupported", true)
	self:SetNWBool("carkeysCustomAlarm", true)
	self:SetNWString("carkeysCAlarmSound", "starlingalarm")
end



function ENT:CreateAI()
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}

	if nak_color_planes_when_spawned:GetBool() == false then
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	
	
	self:SetBodygroup( 2,1 )
	self:SetBodygroup( 3,1 )
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

end

function ENT:OpenHatch()
	self:EmitSound( "lfs/bf109/gear.wav" )
	if self:GetBayOpen() > 0.8 then
		self.OpenClose = 0
	elseif self:GetBayOpen() < 0.2 then
		self.OpenClose = 1
	end
end

function ENT:DropBombs()
	local reloadtime = self:GetBombSelectionTime()
	local bombselection = self:GetBombSelection()
	
	if self:CanBombsAttack() and self:GetBombsAmmo() > 0 and self:GetBombsType() < 4 then
		if self:IsValid() then
			self:SetNextBombs( reloadtime )
			self:TakeBombsAmmo()
			local ent = ents.Create( bombselection )
			local Pos = self:LocalToWorld( Vector(-40,0,38) )
			ent:SetPos( Pos )
			ent:SetAngles( self:GetAngles() )
			ent:Spawn()
			ent:Activate()
			local speed = self:GetVelocity()
			ent:GetPhysicsObject():SetMass(1000)
			ent:GetPhysicsObject():AddVelocity(speed)
			ent:SetPhysicsAttacker(self:GetDriver())
			ent.Armed = true
			timer.Simple( reloadtime, function() if self:IsValid() and self:GetBombsAmmo() > 0 then self:EmitSound( "common/wpn_hudon.ogg" ) end end)
		end
	end
end

function ENT:TakeBombsAmmo(ammo)
	ammo = ammo or 1
	self.SetBombsAmmo( math.max(self:GetBombsAmmo() - ammo,0) )
end

function ENT:SetNextBombs(pause)
	self.NextBombs = CurTime() + pause
	self:SetBombsTime(self.NextBombs)
end

function ENT:CanBombsAttack()
	self.NextBombs = self.NextBombs or 0	
	return self.NextBombs < CurTime()
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