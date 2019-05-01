local NAK_CONVAR = { FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE }


CreateConVar("nak_cuban800_overpowered_bombs"					,  "0"  , NAK_SERVER_CONVAR)
CreateConVar("nak_color_planes_when_spawned"					,  "0"  , NAK_SERVER_CONVAR)
CreateConVar("nak_ai_lazer_infinite_missles"					,  "0"  , NAK_SERVER_CONVAR)
CreateConVar("nak_lazer_infinite_missles"					,  "0"  , NAK_SERVER_CONVAR)
CreateConVar("nak_ai_lazer_dont_use_missles"					,  "0"  , NAK_SERVER_CONVAR)

CreateClientConVar("nak_lazer_no_exhaust"					,  "0"  , NAK_SERVER_CONVAR)

NAK = istable( NAK ) and NAK or {} -- lets check if the NAK (plz luna u took it first :O) table exists. if not, create it!
NAK.GTAVLFS = {}

NAK.GTAVLFS.VERSION = 7
--STOP FUGING TOUCHING GITHUB YOU KEEP ADDING COMMITS WITH YOUR STUPID LITTLE FINGERS AND MAKING YOURSELF HAVE TO UPLOAD AGAIN SO THEY ARE SYNCED UGSJIGNSIGNSIJNGKSJ

function NAK.GTAVLFS.CheckUpdates()
	http.Fetch("https://github.com/NotAKidOnSteam/-LFS-GTAV-Planes", function(contents,size) 
		local LatestVersion = tonumber( string.match( contents, "%s*(%d+)\n%s*</span>\n%s*commits" ) ) or 0  -- i took this from acf. I hope they don't mind
		
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