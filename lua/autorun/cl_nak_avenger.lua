
surface.CreateFont( "NAKHealth", {
	font = "Arial",
	size = 24,
	weight = 600,
	--antialias = true,
} )
-- font weight kinda acts like layers
surface.CreateFont( "NAKBackground", {
	font = "Arial",
	size = 48,
	weight = 500
} )

local avengerScreen = Material( "models/notakid/gtavredux/avenger_mainhud" )
local avengerBackground = surface.GetTextureID( "models/notakid/gtavredux/avenger_mainhud2" )
local avengerRTT = GetRenderTarget( "NAKHealth", 512, 256 )

local MinZ = 0

local function DrawAvengerHUD( ent, y )
	local nak_avenger_noscreen = GetConVar( "nak_avenger_noscreen" )
	if nak_avenger_noscreen:GetInt() == 1 then 
		ent:SetSubMaterial( "14", "models/notakid/gtavredux/script_rt_dials_lazer" )
	else
		ent:SetSubMaterial( "14", "models/notakid/gtavredux/avenger_mainhud" )
	end
	if nak_avenger_noscreen:GetInt() == 1 then return end
	
	local gear = ent:GetHP()
	local drawHP = math.Round( ent:GetHP() )
	local speed = math.Round(ent:GetVelocity():Length() * 0.09144 *.75)
	local w, h = surface.GetTextSize( gear )

	local ZPos = math.Round( ent:GetPos().z,0)
	if (ZPos + MinZ)< 0 then MinZ = math.abs(ZPos) end
	local alt = math.Round( (ent:GetPos().z + MinZ) * 0.0254,0)

	w = w+64
	y = y - h / 2
		-- roll screen background
		surface.SetDrawColor( 10,135,193 )
		surface.DrawRect( 0, 91.5, 205, 80)
		
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 255 - drawHP/6 / 100 * 255, drawHP/6 / 100 * 255, 0 )
		surface.SetTextPos(427, y-83)
		surface.DrawText( math.Round( drawHP ) )	
		

		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(329, y+18)
		surface.DrawText( "ALT: "..alt + 3 .."m" )	
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(329, y+40)
		surface.DrawText( "IAS: "..speed .." km/h" )	
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(21, y+108)
		surface.DrawText( "Bomb Type: "..ent:GetBombsType() )	
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(21, y+129.5)
		surface.DrawText( "Ammo: "..ent:GetBombsAmmo() )
		
		if ent:GetBayOpen() == 0 then
			Bay = "Open"
		else
			Bay = "Closed"
		end
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(21, y+150)
		surface.DrawText( "Bay: ".. Bay )
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(8, y+-75)
		surface.DrawText( "Locked Cargo Info" )
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(8, y+-55)
		surface.DrawText( "Mass: ".. ent:GetNWFloat("CargoMass") )
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(322, y+108)
		surface.DrawText( "Throttle: ".. math.Round(ent:GetThrottlePercent()) .."%" )
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 50 ,255, 50 )
		surface.SetTextPos(322, y+129.5)
		surface.DrawText( "RPM: ".. math.Round(ent:GetRPM()) )
		

		
		local Roll = ent:GetAngles().roll	
		local X = math.cos( math.rad( Roll ) )
		local Y = math.sin( math.rad( Roll ) )

		draw.NoTexture()
		surface.SetDrawColor( 147 ,69, 21 )
		surface.DrawTexturedRectRotatedPoint( 102.5, 160, 200, 40, 0, 1, 1 )
		--THE CODE WAS SUPPOSED TO MAKE THE BROWN ON THE SCREEN ROTATE BUT DUE TO HOW THE MATERIAL IS NOT A SQUARE I AM NOT DOING THE MATH TO MAKE THINGS EVEN
		--ive been here for 3 hours... this is good enough ok
		
		if math.Round(Roll) >9 then
			MoveTextPos = 88
		elseif math.Round(Roll) < 0 then
			MoveTextPos = 88
		else 
			MoveTextPos = 96
		end
		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( math.abs(Roll) / 100 * 255, math.abs(Roll) * 100 / 255, 0 )
		surface.SetTextPos(MoveTextPos, y+50)
		surface.DrawText( math.Round(Roll) )
		

		

		surface.SetDrawColor( 255, 255, 255, 255 )

		
		surface.SetFont( "NAKHealth" )
		surface.SetTextColor( 255 ,255, 255 )
		TheY = 128
		TheX = 102.5
		Space = 10
		SpaceY = 12
		TheLength = 60
		surface.DrawLine( TheX + X * Space, TheY + Y * SpaceY, TheX + X * TheLength, TheY + Y * TheLength ) 
		surface.DrawLine( TheX - X * Space, TheY - Y * SpaceY, TheX - X * TheLength, TheY - Y * TheLength ) 
		
		draw.OutlinedBox( 0, 91.5, 205.5, 76, 10, color_black )

		
		
end
-- gmod wiki had this yeet BUT I CANT YUSE UT
function surface.DrawTexturedRectRotatedPoint( x, y, w, h, rot, x0, y0 )

	local c = math.cos( math.rad( rot ) )
	local s = math.sin( math.rad( rot ) )

	local newx = y0 * s - x0 * c
	local newy = y0 * c + x0 * s

	surface.DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )

end
-- k outline time
function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 1.4 )
	end
end

local function RenderAvengerPod( ent )
	local TEX_SIZE = 512
	local TEX_SIZEH = 256
	local oldW = ScrW()
	local oldH = ScrH()
	avengerScreen:SetTexture( "$baseTexture", avengerRTT )
	avengerScreen:SetTexture( "$selfillummask", avengerRTT )

	local oldRT = render.GetRenderTarget()
	
	render.SetRenderTarget( avengerRTT )
	render.SetViewPort(0, 0, TEX_SIZE, TEX_SIZEH)
	cam.Start2D()
	
		surface.SetDrawColor( 255, 255, 255, 255)
		surface.SetTexture( avengerBackground )
		surface.DrawTexturedRect(0, 0, TEX_SIZE, TEX_SIZEH)
		surface.SetFont( "NAKBackground" )
		DrawAvengerHUD( ent, 104 )
	
	cam.End2D()
	render.SetRenderTarget( oldRT )
	render.SetViewPort(0, 0, oldW, oldH)
	
end

local function DrawHudAvenger()
	local ply = LocalPlayer()
	
	if !ply or !ply:Alive() then return end

	if ply:GetViewEntity() ~= ply then return end

	local Pod = ply:GetVehicle()
	
	local Parent = ply:lfsGetPlane()
	if not Parent:GetNWBool("NAKGTAV") == true then return end
	RenderAvengerPod(Parent)
end
hook.Add( "Tick", "nak_gtav_avenger", DrawHudAvenger)