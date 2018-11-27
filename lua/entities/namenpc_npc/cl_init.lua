include("shared.lua")
include("namenpc/config/config.lua")
include("namenpc/config/lang.lua")

surface.CreateFont("namenpc_npc1", {
  font = NameNPC.Config.Font,
  size = 50
})

function ENT:Initalize()

	self.AutomaticFrameAdvance = true

end

function ENT:Draw()

	self:DrawModel()

  local ang = self:GetAngles()
  local lpos = Vector(2, 0, 78)
  local pos = self:LocalToWorld(lpos)
  ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
  ang:RotateAroundAxis(self:GetAngles():Up(), 90)

  if(NameNPC.Config.NPC.Follow3D2D == true) then

    eye_angles = LocalPlayer():EyeAngles()
  	ang = Angle(0, eye_angles.y - 90, -eye_angles.p - 270)

  end

	cam.Start3D2D(pos, ang, 0.1)

  surface.SetFont("namenpc_npc1")
  local TextSize = surface.GetTextSize(NameNPC.Lang.NPC3D2D) + 25

	draw.RoundedBox(0, ((TextSize / 2) - (TextSize / 2) * 2), -10, TextSize, 50, Color(30, 30, 30, 255))

  if(NameNPC.Config.NPC.Outlined3D2D == true) then

    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawOutlinedRect( ((TextSize / 2) - (TextSize / 2) * 2), -10, TextSize, 50)

  end
	draw.SimpleText(NameNPC.Lang.NPC3D2D, "namenpc_npc1", 0, 15, Color(255, 255, 255, 255), 1, 1)

	cam.End3D2D()

end
