local function CreateConstraintSystem()

	-- This is probably the best place to be calling this
	GarbageCollectConstraintSystems()

	local iterations = GetConVarNumber( "gmod_physiterations" )

	local System = ents.Create("phys_constraintsystem")
	System:SetKeyValue( "additionaliterations", iterations )
	System:Spawn()
	System:Activate()

	table.insert( ConstraintSystems, System )
	System.UsedEntities = {}

	return System

end




--[[----------------------------------------------------------------------
	onStartConstraint( Ent1, Ent2 )
	Should be called before creating a constraint
------------------------------------------------------------------------]]
local function onStartConstraint( Ent1, Ent2 )


	-- Any constraints called after this call will use this system
	SetPhysConstraintSystem( system )

end

--[[----------------------------------------------------------------------
	onFinishConstraint( Ent1, Ent2 )
	Should be called before creating a constraint
------------------------------------------------------------------------]]
local function onFinishConstraint( Ent1, Ent2 )

	-- Turn off constraint system override
	SetPhysConstraintSystem( NULL )

end

local function SetPhysicsCollisions( Ent, b )

	if ( !IsValid( Ent ) || !IsValid( Ent:GetPhysicsObject() ) ) then return end

	Ent:GetPhysicsObject():EnableCollisions( b )

end

--[[----------------------------------------------------------------------
	RemoveConstraints( Ent, Type )
	Removes all constraints of type from entity
------------------------------------------------------------------------]]
function RemoveConstraints( Ent, Type )

	if ( !Ent:GetTable().Constraints ) then return end

	local c = Ent:GetTable().Constraints
	local i = 0

	for k, v in pairs( c ) do

		if ( !IsValid( v ) ) then

			c[ k ] = nil

		elseif ( v:GetTable().Type == Type ) then

			-- Make sure physics collisions are on!
			-- If we don't the unconstrained objects will fall through the world forever.
			SetPhysicsCollisions( v:GetTable().Ent1, true )
			SetPhysicsCollisions( v:GetTable().Ent2, true )

			c[ k ] = nil
			v:Remove()

			i = i + 1
		end

	end

	if ( table.Count( c ) == 0 ) then
		-- Update the network var and clear the constraints table.
		Ent:IsConstrained()
	end

	local bool = i != 0
	return bool, i

end


--[[----------------------------------------------------------------------
	RemoveAll( Ent )
	Removes all constraints from entity
------------------------------------------------------------------------]]
function RemoveAll( Ent )

	if ( !Ent:GetTable().Constraints ) then return end

	local c = Ent:GetTable().Constraints
	local i = 0
	for k, v in pairs( c ) do

		if ( v:IsValid() ) then

			-- Make sure physics collisions are on!
			-- If we don't the unconstrained objects will fall through the world forever.
			SetPhysicsCollisions( v:GetTable().Ent1, true )
			SetPhysicsCollisions( v:GetTable().Ent2, true )

			v:Remove()
			i = i + 1
		end
	end

	-- Update the network var and clear the constraints table.
	Ent:IsConstrained()

	local bool = i != 0
	return bool, i

end

--[[----------------------------------------------------------------------
	Find( Ent1, Ent2, Type, Bone1, Bone2 )
	Removes all constraints from entity
------------------------------------------------------------------------]]
function Find( Ent1, Ent2, Type, Bone1, Bone2 )

	if ( !Ent1:GetTable().Constraints ) then return end

	local c = Ent1:GetTable().Constraints

	for k, v in pairs( Ent1:GetTable().Constraints ) do

		if ( v:IsValid() ) then

			local CTab = v:GetTable()

			if ( CTab.Type == Type && CTab.Ent1 == Ent1 && CTab.Ent2 == Ent2 && CTab.Bone1 == Bone1 && CTab.Bone2 == Bone2 ) then
				return v
			end

			if ( CTab.Type == Type && CTab.Ent2 == Ent1 && CTab.Ent1 == Ent2 && CTab.Bone2 == Bone1 && CTab.Bone1 == Bone2 ) then
				return v
			end

		end

	end

	return nil

end

--[[----------------------------------------------------------------------
	CanConstrain( Ent, Bone )
	Returns false if we shouldn't be constraining this entity
------------------------------------------------------------------------]]
function CanConstrain( Ent, Bone )

	if ( !Ent ) then return false end
	if ( !isnumber( Bone ) ) then return false end
	if ( !Ent:IsWorld() && !Ent:IsValid() ) then return false end
	if ( !Ent:GetPhysicsObjectNum( Bone ) || !Ent:GetPhysicsObjectNum( Bone ):IsValid() ) then return false end

	return true

end

--[[----------------------------------------------------------------------
	CalcElasticConsts( ... )
	This attempts to scale the elastic constraints such as the winch
	to keep a stable but responsive constraint..
------------------------------------------------------------------------]]
local function CalcElasticConsts( Phys1, Phys2, Ent1, Ent2, iFixed )

	local minMass = 0

	if ( Ent1:IsWorld() ) then minMass = Phys2:GetMass()
	elseif ( Ent2:IsWorld() ) then minMass = Phys1:GetMass()
	else
		minMass = math.min( Phys1:GetMass(), Phys2:GetMass() )
	end

	-- const, damp
	local const = minMass * 100
	local damp = const * 0.2

	if ( iFixed == 0 ) then

		const = minMass * 50
		damp = const * 0.1

	end

	return const, damp

end


--[[----------------------------------------------------------------------
	CreateKeyframeRope( ... )
	Creates a rope without any constraint
------------------------------------------------------------------------]]
function CreateKeyframeRope( Pos, width, material, Constraint, Ent1, LPos1, Bone1, Ent2, LPos2, Bone2, kv )

	-- No rope if 0 or minus
	if ( width <= 0 ) then return nil end

	-- Clamp the rope to a sensible width
	width = math.Clamp( width, 1, 100 )

	local rope = ents.Create( "keyframe_rope" )
	rope:SetPos( Pos )
	rope:SetKeyValue( "Width", width )

	if ( isstring( material ) ) then
		local mat = Material( material )
		if ( material && !string.find( mat:GetShader():lower(), "spritecard" ) ) then rope:SetKeyValue( "RopeMaterial", material ) end
	end

	-- Attachment point 1
	rope:SetEntity( "StartEntity", Ent1 )
	rope:SetKeyValue( "StartOffset", tostring( LPos1 ) )
	rope:SetKeyValue( "StartBone", Bone1 )

	-- Attachment point 2
	rope:SetEntity( "EndEntity", Ent2 )
	rope:SetKeyValue( "EndOffset", tostring( LPos2 ) )
	rope:SetKeyValue( "EndBone", Bone2 )

	if ( kv ) then
		for k, v in pairs( kv ) do

			rope:SetKeyValue( k, tostring( v ) )

		end
	end

	rope:Spawn()
	rope:Activate()

	-- Delete the rope if the attachments get killed
	Ent1:DeleteOnRemove( rope )
	Ent2:DeleteOnRemove( rope )
	if ( Constraint && Constraint:IsValid() ) then Constraint:DeleteOnRemove( rope ) end

	return rope

end

--[[----------------------------------------------------------------------
	AddConstraintTable( Ent, Constraint, Ent2, Ent3, Ent4 )
	Stores info about the constraints on the entity's table
------------------------------------------------------------------------]]
function AddConstraintTable( Ent, Constraint, Ent2, Ent3, Ent4 )

	if ( !IsValid( Constraint ) ) then return end

	if ( Ent:IsValid() ) then

		Ent:GetTable().Constraints = Ent:GetTable().Constraints or {}
		table.insert( Ent:GetTable().Constraints, Constraint )
		Ent:DeleteOnRemove( Constraint )

	end

	if ( Ent2 && Ent2 != Ent ) then
		AddConstraintTable( Ent2, Constraint, Ent3, Ent4 )
	end

end

--[[----------------------------------------------------------------------
	AddConstraintTableNoDelete( Ent, Constraint, Ent2, Ent3, Ent4 )
	Stores info about the constraints on the entity's table
------------------------------------------------------------------------]]
function AddConstraintTableNoDelete( Ent, Constraint, Ent2, Ent3, Ent4 )

	if ( !IsValid( Constraint ) ) then return end

	if ( Ent:IsValid() ) then

		Ent:GetTable().Constraints = Ent:GetTable().Constraints or {}
		table.insert( Ent:GetTable().Constraints, Constraint )

	end

	if ( Ent2 && Ent2 != Ent ) then
		AddConstraintTableNoDelete( Ent2, Constraint, Ent3, Ent4 )
	end

end







--[[----------------------------------------------------------------------

	PlaneWeld( ... )

	Creates a solid PlaneWeld constraint
	I DONT WANT TO REMOVE A PROPS WELD CONSTRAINT IF IT IS IN THE PLANE SO I HAVE TO MAKE A NEW ONE 

------------------------------------------------------------------------]]

function PlaneWeld( Ent1, Ent2, Bone1, Bone2, forcelimit, nocollide, deleteonbreak )



	if ( Ent1 == Ent2 && Bone1 == Bone2 ) then return false end

	if ( !CanConstrain( Ent1, Bone1 ) ) then return false end

	if ( !CanConstrain( Ent2, Bone2 ) ) then return false end



	if ( Find( Ent1, Ent2, "PlaneWeld", Bone1, Bone2 ) ) then



		-- A PlaneWeld already exists between these two physics objects.

		-- There's totally no point in re-creating it. It doesn't make

		-- the PlaneWeld any stronger - that's just an urban legend.

		return false



	end



	-- Don't PlaneWeld World to objects, PlaneWeld objects to World!

	-- Prevents crazy physics on some props

	if ( Ent1:IsWorld() ) then

		Ent1 = Ent2

		Ent2 = game.GetWorld()

	end



	local Phys1 = Ent1:GetPhysicsObjectNum( Bone1 )

	local Phys2 = Ent2:GetPhysicsObjectNum( Bone2 )



	onStartConstraint( Ent1, Ent2 )



		-- Create the constraint

		local Constraint = ents.Create( "phys_constraint" )

		if ( forcelimit ) then Constraint:SetKeyValue( "forcelimit", forcelimit ) end

		if ( nocollide ) then Constraint:SetKeyValue( "spawnflags", 1 ) end

		Constraint:SetPhysConstraintObjects( Phys2, Phys1 )

		Constraint:Spawn()

		Constraint:Activate()



	onFinishConstraint( Ent1, Ent2 )

	AddConstraintTable( Ent1, Constraint, Ent2 )



	-- Optionally delete Ent1 when the PlaneWeld is broken

	-- This is to fix bug #310

	if ( deleteonbreak ) then

		Ent2:DeleteOnRemove( Ent1 )

	end



	-- Make a constraints table

	local ctable = {

		Type = "PlaneWeld",

		Ent1 = Ent1,

		Ent2 = Ent2,

		Bone1 = Bone1,

		Bone2 = Bone2,

		forcelimit = forcelimit,

		nocollide = nocollide,

		deleteonbreak = deleteonbreak

	}



	Constraint:SetTable( ctable )



	Phys1:Wake()

	Phys2:Wake()



	return Constraint



end

duplicator.RegisterConstraint( "PlaneWeld", PlaneWeld, "Ent1", "Ent2", "Bone1", "Bone2", "forcelimit", "nocollide", "deleteonbreak" )

