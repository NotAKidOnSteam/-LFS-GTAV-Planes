local NAK_CONVAR = { FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE }
local NAK_CONVAR_CL = { FCVAR_ARCHIVE }


CreateConVar("nak_overpowered_bombs", "0", NAK_CONVAR)
CreateConVar("nak_color_planes_when_spawned", "0", NAK_CONVAR)
CreateConVar("nak_ai_infinite_missles", 0, NAK_CONVAR)
CreateConVar("nak_infinite_missles", 0, NAK_CONVAR)
CreateConVar("lfs_giblifetime", 5, NAK_CONVAR)
CreateConVar("lfs_nogibexplosion", "0", NAK_CONVAR)
CreateConVar("lfs_nogibexplosioncustomforcevalue", 10, NAK_CONVAR)
CreateConVar("nak_ai_dont_use_missles", "0", NAK_CONVAR)

CreateClientConVar("nak_no_exhaust", "0", true, true, "Removes LFS GTAV jet planes exhaust from being spawned on the client!") --adding so people that lag can disable it
CreateClientConVar("nak_avenger_noscreen", "0", true, true, "Disables the LFS GTAV Avengers screen!" ) --adding so people that lag can disable it
CreateClientConVar("nak_boost_effects", "0"  , true, true, "Removes the postprossessing effects when boosting!") --adding so people that lag can disable it

NAK = istable( NAK ) and NAK or {} -- lets check if the NAK (plz luna u took it first :O) table exists. if not, create it!
NAK.GTAVLFS = {}

NAK.GTAVLFS.VERSION = 10 --woot

if SERVER then 
	resource.AddWorkshop("1579161327") -- hoping this fixes problems :P 
end




--STOP FUGING TOUCHING GITHUB YOU KEEP ADDING COMMITS WITH YOUR STUPID LITTLE FINGERS AND MAKING YOURSELF HAVE TO UPLOAD AGAIN SO THEY ARE SYNCED UGSJIGNSIGNSIJNGKSJ

--WHAT THE FUCK STOP IT GITHUB JUST PLZ your killing me stop it i just pulled the readme.md to github desktop so i could push version 7 and it updates the commits by 2... STOP IT I CANT PREDICT THE FUTURE

--i dont know what im doing so ill guess 9 and if it doesnt sync up then F in chat instead of github commits ill be commiting dead memes <O/ jk

function NAK.GTAVLFS.CheckUpdates()
	http.Fetch("https://github.com/NotAKidOnSteam/-LFS-GTAV-Planes", function(contents,size) 
		local LatestVersion = tonumber( string.match( contents, "%s*(%d+)\n%s*</span>\n%s*commits" ) ) or 0  -- "i took this from acf. I hope they don't mind" -luna. I notakid stole this from Luna who stole it from ACF. soz boio
		
		if NAK.GTAVLFS.GetVersion() >= LatestVersion then
			print("[NAKoS] is up to date, Version: "..NAK.GTAVLFS.GetVersion())
		else
			print("[NAKoS] dont have the latest update of LFS GTAV Planes! Version: "..LatestVersion..", You have Version: "..NAK.GTAVLFS.GetVersion())
			print("[NAKoS] don't report bugs if your not on the latest version you dumb poop heads >:(")
			timer.Simple(4, function() 
				print("[NAKoS] jk ur not dumb poop heads plz no hate ill make a convar for these alerts in a bit ;)")
			end )
			
			if CLIENT then 
				timer.Simple(18, function() 
					chat.AddText( Color( 255, 0, 0 ), "[NAKoS] an update for LFS GTAV Planes is available!" )
					surface.PlaySound( "lfs/notification/ding.ogg" )
				end)
			end
		end
	end)
end

function NAK.GTAVLFS.GetVersion()
	return NAK.GTAVLFS.VERSION
end

NAK.GTAVLFS.CheckUpdates()


-- this code is to make the blur effect in 
if CLIENT then

	local function PaintPlaneHudGTAVBombs( ent, X, Y )
		if not IsValid( ent ) then return end
		if not ent.GTAVBoost == true then return end
		local vel = ent:GetVelocity():Length()
		local speed = math.Round(vel * 0.09144,0)

		nak_boost_effects = GetConVar( "nak_boost_effects" )
		if ent:GetBoosting() and nak_boost_effects:GetBool() == true then
			DrawToyTown( speed/120, ScrH()/2 )
			DrawBloom( 0.8 , 0.2, 9, 9, 1, 1, 2, 1.9, 0 )
		end
	end

	hook.Add( "HUDPaint", "GTAVBoostEffectsNAK", function()

		local ply = LocalPlayer()

		if ply:GetViewEntity() ~= ply then return end

		local Pod = ply:GetVehicle()

		local Parent = ply:lfsGetPlane()

		local X = ScrW()

		local Y = ScrH()

		PaintPlaneHudGTAVBombs( Parent, X, Y )

	end)

end
simfphys.LFS:AddKey( "BOMB_DROP", "plane",  "Bomb Drop (GTAV Planes)", KEY_G, "cl_nak_lfs_bombdrop", 0 )
simfphys.LFS:AddKey( "BAY_DOOR", "plane",  "Bay Door (GTAV Planes)", KEY_F, "cl_nak_lfs_baydoor", 0 )

--any plane with boost that has AI will boost if damaged for 8 seconds
hook.Add( "EntityTakeDamage", "AIBoostIfAttacked", function( target, dmginfo )
	if not target.GTAVBoost == true then return end
	if not target:GetAI() then return end
	target.AIHit = true
	
	if target.AIHit then
		timer.Adjust( "BoostPlaneDamagedWithAI", 2 + target.AIDamagedExtend, 1, function()
			if target:IsValid() then
				target.AIDamaged = false 
				target.AIDamagedExtend = 0
			end
		end) 
	end

	target.AIDamagedExtend = target.AIDamagedExtend + 1
	if target.AIDamagedExtend == 1 then
		target.AIDamaged = true
		AIDamagedScaredBoost(target)
	end
	target.AIHit = false
end )

function AIDamagedScaredBoost(target)
	timer.Create( "BoostPlaneDamagedWithAI", 2, 1, function()
		if target:IsValid() then
			target.AIDamaged = false 
			target.AIDamagedExtend = 0
		end
	end) 
end

hook.Add("EntityRemoved", "AIBoostIfAttackedAndThenRemoved", function(ent) 
	if not ent.GTAVBoost == true then return end
	
	ent:StopSound("GTAV_BOOST_START") 
	ent:StopSound("GTAV_BOOST_END") 
end)