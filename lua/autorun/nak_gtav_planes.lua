local NAK_CONVAR = { FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE }
local NAK_CONVAR_CL = { FCVAR_ARCHIVE }


CreateConVar("nak_overpowered_bombs"					,  "0"  , NAK_CONVAR)
CreateConVar("nak_color_planes_when_spawned"					,  "0"  , NAK_CONVAR)
CreateConVar("nak_ai_infinite_missles"					,  "0"  , NAK_CONVAR)
CreateConVar("nak_infinite_missles"					,  "0"  , NAK_CONVAR)
CreateConVar("lfs_giblifetime"					,  5  , NAK_CONVAR)
CreateConVar("lfs_nogibexplosion"					,  0  , NAK_CONVAR)
CreateConVar("lfs_nogibexplosioncustomforcevalue"					,  10  , NAK_CONVAR)
CreateConVar("nak_ai_dont_use_missles"					,  "0"  , NAK_CONVAR)

CreateClientConVar("nak_no_exhaust"					,  "0"  , NAK_CONVAR_CL) --adding so people that lag can disable it
CreateClientConVar("nak_boost_effects"					,  "0"  , NAK_CONVAR_CL) --adding so people that lag can disable it

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

-- if u need the bomb hud code idc. if you can read the code and figure it out then take it :P (i cant even read it lol)

--I can kinda figure it out but not really... figuring this out took me 4 hours. NOOO ITS 6:30 AM! I GTG FOR SCHOOLGIUSJNOJGNDFGNS



if CLIENT then

	local function PaintPlaneHudGTAVBombs( ent, X, Y )

		if not IsValid( ent ) then return end
		if not ent.BombPlane == true then return end
		
		local vel = ent:GetVelocity():Length()
		local speed = math.Round(vel * 0.09144,0)
		nak_boost_effects = GetConVar( "nak_boost_effects" )
		
		if ent:GetBoosting() and nak_boost_effects:GetBool() == true then
			DrawToyTown( speed/120, ScrH()/2 )
			DrawBloom( 0.8 , 0.2, 9, 9, 1, 1, 2, 1.9, 0 )
		end
		
		if ent:GetLockBoost() == false then
			locked = 255
		elseif ent:GetLockBoost() == true then
			locked = 0
		end
	
		if ent:GetMaxBombsAmmo() > -1 then

			draw.SimpleText( "BOMB", "LFS_FONT", 10, 135, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			draw.SimpleText( ent:GetBombsAmmo(), "LFS_FONT", 120, 135, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			if ent:GetBodygroup( 3 ) == 1 then
				draw.SimpleText( "Boost", "LFS_FONT", 10, 150, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
				draw.SimpleText( ent:GetBoost(), "LFS_FONT", 120, 150, Color(255,locked,locked,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			end
		end 
	end
	

	

	

	hook.Add( "HUDPaint", "!!?1123GTAVPLANESLFSNUKES", function()

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