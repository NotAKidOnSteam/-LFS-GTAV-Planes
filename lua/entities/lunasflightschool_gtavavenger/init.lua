-- YOU CAN EDIT AND REUPLOAD THIS FILE. 
-- HOWEVER MAKE SURE TO RENAME THE FOLDER TO AVOID CONFLICTS

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName ) -- called by garry
	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent.dOwnerEntLFS = ply  -- this is important
	ent:SetPos( tr.HitPos + tr.HitNormal * 130 ) -- spawn 20 units above ground
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:OnTick() -- use this instead of "think"
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
		local KeyPressedBomb = self:GetDriver():lfsGetInput( "BOMB_DROP" )

		if KeyPressedBomb == true then
			self.KeyPressedBomb  = self.KeyPressedBomb + 1
		elseif KeyPressedBomb == false then
			if self.KeyPressedBomb > 11 and self:GetBayOpen() ~= 1 and not self.NearGround then
				--drop bomb
				self:DropBombs()
			elseif self.KeyPressedBomb > 2 and self.KeyPressedBomb < 10 then 
				--open bay door
				self:OpenHatch()	
			end
			self.KeyPressedBomb = 0 
		end
	end
	if self.OpenClose == 0 then
		self:SetBayOpen(0)
	elseif self.OpenClose == 1 then
		self:SetBayOpen(1)
	end

	if self:GetCargoLock() then
		self:SetSubMaterial( "15", "models/notakid/gtavredux/avenger_locked" )
	else
		self:SetSubMaterial( "15", "models/notakid/gtavredux/avenger_unlocked" )
	end
	if self:GetDoorOpen() then
		self:SetSubMaterial( "16", "models/notakid/gtavredux/avenger_open" )
	else
		self:SetSubMaterial( "16", "models/notakid/gtavredux/avenger_closed" )
	end

	if self:GetActive() and not self:GetAI() then
		local KeyPressedBayDoor = self:GetDriver():lfsGetInput( "BAY_DOOR" )

		if KeyPressedBayDoor == true then
			self.KeyPressedBayDoor  = self.KeyPressedBayDoor + 1
		elseif KeyPressedBayDoor == false then
			if self.KeyPressedBayDoor > 11 then
				if self:GetCargoLock() then
					self:LockCargo(false)
				elseif not self:GetCargoLock() then
					self:LockCargo(true)
				end
			elseif self.KeyPressedBayDoor > 2 and self.KeyPressedBayDoor < 10 then 
				--CLOSE OPEN DOOR
				if self:GetDoorOpen() then
					self:ManageDoors(false)
				elseif not self:GetDoorOpen() then
					self:ManageDoors(true)
				end
			end
			self.KeyPressedBayDoor = 0 
		end
	end

	
	if self:GetDoorOpen() then
		if self.DoorColSpawned then
			self.DoorColSpawned = false
			if self.bootcol:IsValid() then self.bootcol:Remove() end 
		end
	elseif not self:GetDoorOpen() then
		if not self.DoorColSpawned then
			self.bootcol = ents.Create("prop_physics")
			self.bootcol:SetModel("models/notakid/gtav/planes/avenger/avenger_boot.mdl")
			self.bootcol:SetPos(self:GetPos())
			self.bootcol:SetAngles(Angle(self:GetAngles(),self:GetAngles(),self:GetAngles()))
			self.bootcol:Spawn()
			self.bootcol:GetPhysicsObject():SetMass(100)
			constraint.Weld( self, self.bootcol, 0, 0, 0, true )
			self.bootcol:Activate()
			self.bootcol:GetPhysicsObject():SetDragCoefficient(-9000000)
			self.bootcol:SetNoDraw( true )
			self.bootcol:DrawShadow( false )
			self.DoorColSpawned = true
			self:DeleteOnRemove( self.bootcol )
		end
	end
	
	local locked = self:GetNWBool("carKeysVehicleLocked")
	
	if locked and not self.lockedonce then
		self.lockedonce = true
		if self:GetDoorOpen() then
			self:OnDoorClose()
		end
		self:LockCargo( true )
	elseif not locked and self.lockedonce then
		self.lockedonce = false
		--self:OnDoorOpen()
		--self:LockCargo( false )
	end
end

function ENT:OnDoorOpen()
	self:EmitSound( "lfs/crysis_vtol/door_open.wav" )
	self:SetDoorOpen( true )
	self:SetDoorOpenNum( 0 )
end

function ENT:OnDoorClose()
	self:EmitSound( "lfs/crysis_vtol/door_close.wav" )
	self:SetDoorOpen( false )
	self:SetDoorOpenNum( 1 )
end

function ENT:ManageDoors( Enabled )
	if Enabled then
		self:OnDoorOpen()
	else
		self:OnDoorClose()
	end
end

function ENT:LockCargo( Enabled )
	local tr = util.TraceLine({
	start = self:LocalToWorld( Vector(42.725,0,26.933) ),
	endpos = self:LocalToWorld( Vector(42.725,0,-64.425) ),
	filter = self,
	})
	local grabprop = tr.Entity
	if Enabled then
		if ( grabprop:IsValid() and not grabprop:IsPlayer() ) then 
			constraint.PlaneWeld( self, grabprop, 0, 0, 0, true )
			grabprop:DrawShadow( false )
			self:SetCargoLock(true)
			self:EmitSound( "handle_release.wav" )
			self:SetNWFloat("CargoMass", grabprop:GetPhysicsObject():GetMass() )
		end
	else
		if ( grabprop:IsValid() and not grabprop:IsPlayer() ) then 
			constraint.RemoveConstraints( self, "PlaneWeld" ) 
			grabprop:DrawShadow( true )
			self:SetCargoLock(false)
			self:EmitSound( "handle_down.wav" )
			self:SetNWFloat("CargoMass", 0 )
		end
	end
end

function ENT:RunOnSpawn() -- called when the vehicle is spawned
	self:SetNWBool("CanBombAttack", false)
	self.KeyPressedBayDoor = 0
	self.OpenClose = 1
	self.KeyPressedBomb = 0
	self.DoorColSpawned = false
	self:SetDoorOpenNum(0)
	self:SetDoorOpen( true )
	self:SetNWBool("NAKGTAV", true)
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	if nak_color_planes_when_spawned:GetBool() == true then
		local colorSelect = { Color(0, 0, 0, 255), Color(72, 72, 72, 255), Color(95, 127, 63, 255)}
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end	
	self:SetNWBool("carkeysSupported", true)
	self:SetNWBool("carkeysCustomAlarm", true)
	self:SetNWFloat("carkeysForwardPos", 200 )
	self:SetNWFloat("carkeysRightPos", 0 )
	self:SetNWFloat("carkeysUpPos", 0 )
	self:SetNWString("carkeysCAlarmSound", "avengeralarm")
end

function ENT:PrimaryAttack()
	if self:GetAI() then
		self:OpenHatch()	
		self:DropBombs()
		self:OpenHatch()	
	end
end

function ENT:SecondaryAttack()
end

function ENT:CreateAI()
	nak_color_planes_when_spawned = GetConVar( "nak_color_planes_when_spawned" )
	self:SetBombsType(math.random( 0,4,1 ))
	if nak_color_planes_when_spawned:GetBool() == false then
		local colorSelect = { Color(127, 111, 63, 255), Color(255, 233, 127, 255), Color(127, 159, 255, 255), Color(95, 127, 63, 255), Color(255, 191, 0, 255)}
		self:SetColor( colorSelect[ math.random( #colorSelect ) ] ) 
	end
	self:SetDoorOpenNum(1)
	self:SetDoorOpen( false )
end


function ENT:OnEngineStarted()
	--[[ play engine start sound? ]]--
	self:EmitSound( "avenger_start.wav" )
	local RotorWash = ents.Create( "env_rotorwash_emitter" )
	local RotorWash2 = ents.Create( "env_rotorwash_emitter" )
	
	if IsValid( RotorWash ) and IsValid( RotorWash2 ) then
		RotorWash:SetPos( self:LocalToWorld( Vector(50,350,0) ) )
		RotorWash2:SetPos( self:LocalToWorld( Vector(50,-350,0) ) )
		RotorWash:SetAngles( Angle(0,0,0) )
		RotorWash2:SetAngles( Angle(0,0,0) )
		RotorWash:Spawn()
		RotorWash2:Spawn()
		RotorWash:Activate()
		RotorWash2:Activate()
		RotorWash:SetParent( self )
		RotorWash2:SetParent( self )
		
		RotorWash.DoNotDuplicate = true
		RotorWash2.DoNotDuplicate = true
		self:DeleteOnRemove( RotorWash )
		self:DeleteOnRemove( RotorWash2 )
		self:dOwner( RotorWash )
		self:dOwner( RotorWash2 )
		
		self.RotorWashEnt = RotorWash
		self.RotorWashEnt2 = RotorWash2
	end
end

function ENT:OnEngineStopped()
	--[[ play engine stop sound? ]]--
	self:EmitSound( "vehicles/airboat/fan_motor_shut_off1.wav" )
	if IsValid( self.RotorWashEnt ) then
		self.RotorWashEnt:Remove()
	end
	if IsValid( self.RotorWashEnt2 ) then
		self.RotorWashEnt2:Remove()
	end
end

function ENT:OnLandingGearToggled( bOn )
	self:EmitSound( "vehicles/tank_readyfire1.wav" )
end

function ENT:OnVtolMode( On )
	if On then
		self:EmitSound( "lfs/crysis_vtol/vtol_off.wav" )
	else
		self:EmitSound( "lfs/crysis_vtol/vtol_on.wav" )
	end
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
			local Pos = self:LocalToWorld( Vector(100,0,-120) )
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