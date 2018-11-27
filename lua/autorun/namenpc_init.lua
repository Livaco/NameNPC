-- Just to save me time
local function conprint(msg)

  if CLIENT then

    MsgC(Color(255, 255, 255), "[")
    MsgC(Color(255, 0, 0), "Name NPC")
    MsgC(Color(255, 255, 255), "] ")
    MsgC(Color(255, 255, 255), msg)
    MsgC(Color(255, 255, 255), "\n")

  else

    MsgC(Color(255, 255, 255), "[")
    MsgC(Color(255, 150, 150), "Name NPC")
    MsgC(Color(255, 255, 255), "] ")
    MsgC(Color(255, 255, 255), msg)
    MsgC(Color(255, 255, 255), "\n")

  end

end

NameNPC = {}
NameNPC.Config = NameNPC.Config or {}
NameNPC.Config.NPC = NameNPC.Config.NPC or {}
NameNPC.Config.VGUI = NameNPC.Config.VGUI or {}
NameNPC.Config.bLogs = NameNPC.Config.bLogs or {}
NameNPC.Lang = NameNPC.Lang or {}

include("namenpc/config/config.lua")
include("namenpc/config/lang.lua")

conprint("Loading Name NPC - By Livaco")
conprint("If you have any issues, make a support ticket at livaco.tk in the dashboard!")

if SERVER then

  conprint("Loading serverside...")

  include("namenpc/core/sv_main.lua")

  AddCSLuaFile("namenpc/core/cl_main.lua")
  AddCSLuaFile("namenpc/config/config.lua")
  AddCSLuaFile("namenpc/config/lang.lua")

  conprint("Serverside loaded.")

else

  conprint("Loading clientside...")

  include("namenpc/core/cl_main.lua")

  conprint("Clientside loaded.")

end
