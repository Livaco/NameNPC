AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("namenpc/config/config.lua")
include("namenpc/config/lang.lua")

function ENT:Initialize()

	self:SetModel(NameNPC.Config.NPC.Model)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetTrigger(true)

	if(NameNPC.Config.NPC.EnableCooldown == true) then

		self.Cooldown = 0

	end

end

function ENT:AcceptInput(name, activator, caller)

	// First things first, check if they are in a blocked group.
	if(NameNPC.Config.NPC.BlockGroups == true) then

		for k,v in pairs(NameNPC.Config.NPC.BlockedGroups) do

			if(caller:GetUserGroup() == v) then

				net.Start("namenpc_message")
				net.WriteString(NameNPC.Lang.NPCBlockedGroups)
				net.Send(caller)

				// bLogs
				if(NameNPC.Config.bLogs.LogNPCFailGroup == true) then

					if NameNPC.blogs then

					  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to open the VGUI from the NPC but was the wrong group!")

					end

				end

				return

			end

		end

	end

	// If there is a cooldown
	if(NameNPC.Config.NPC.EnableCooldown == true) then

		if(self.Cooldown <= CurTime()) then

			self.Cooldown = CurTime() + NameNPC.Config.NPC.Cooldown

		else

			net.Start("namenpc_message")
			net.WriteString(NameNPC.Lang.NPCCooldown)
			net.Send(caller)

			// bLogs
			if(NameNPC.Config.bLogs.LogNPCFailCool == true) then

				if NameNPC.blogs then

				  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to open the VGUI from the NPC but the cooldown was active!")

				end

			end

			return

		end

	end

	// They passed all checks, open the VGUI with a net message.
	net.Start("namenpc_opengui")
	net.Send(caller)

	// bLogs
	if(NameNPC.Config.bLogs.LogNPCUse == true) then

		if NameNPC.blogs then

		  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " open the NPC panel successfully.")

		end

	end

end