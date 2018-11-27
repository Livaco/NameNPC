// All net messages.
util.AddNetworkString("namenpc_message")
util.AddNetworkString("namenpc_opengui")
util.AddNetworkString("namenpc_debugmsg")
util.AddNetworkString("namenpc_submitname")

// bLogs
hook.Add("bLogs_FullyLoaded", "namenpc_loadblogs", function()

  if(NameNPC.Config.bLogs.Enable == true) then

    NameNPC.blogs = bLogs:Module()

    NameNPC.blogs.Category = "Livaco's Scripts"
    NameNPC.blogs.Name     = "NameNPC"
    NameNPC.blogs.Colour   = Color(120, 120, 120, 255)

    bLogs:AddModule(NameNPC.blogs)

  end

end)

/*
template cuz im lazy

if NameNPC.blogs then

  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " cunt")

end
*/

net.Receive("namenpc_submitname", function(len, ply)

  local FirstName = net.ReadString()
  local LastName = net.ReadString()

  if(FirstName == "") then

    net.Start("namenpc_message")
    net.WriteString(NameNPC.Lang.FirstNameEmpty)
    net.Send(ply)

    // bLogs
  	if(NameNPC.Config.bLogs.LogNPCUse == true) then

  		if NameNPC.blogs then

  		  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to change his name but his first name was empty.")

  		end

  	end

    return

  end

  if(LastName == "") then

    net.Start("namenpc_message")
    net.WriteString(NameNPC.Lang.LastNameEmpty)
    net.Send(ply)

    // bLogs
  	if(NameNPC.Config.bLogs.LogNPCUse == true) then

  		if NameNPC.blogs then

  		  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to change his name but his last name was empty.")

  		end

  	end

    return

  end

  local FullName = FirstName .. " " .. LastName

  if(NameNPC.Config.CheckBlockedWords == true) then

    for k,v in pairs(NameNPC.Config.BlockedWords) do

      if(FirstName == v) then

        net.Start("namenpc_message")
        net.WriteString(string.format(NameNPC.Lang.NameContainsBlocked, v))
        net.Send(ply)

        // bLogs
      	if(NameNPC.Config.bLogs.LogNPCUse == true) then

      		if NameNPC.blogs then

      		  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to change his name to " .. FullName .. " but it contained " .. v .. " which is a blocked word.")

      		end

      	end

        return

      end

      if(LastName == v) then

        net.Start("namenpc_message")
        net.WriteString(string.format(NameNPC.Lang.NameContainsBlocked, v))
        net.Send(ply)

        // bLogs
      	if(NameNPC.Config.bLogs.LogNPCUse == true) then

      		if NameNPC.blogs then

      		  NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to change his name to " .. FullName .. " but it contained " .. v .. " which is a blocked word.")

      		end

      	end

        return

      end

    end

  end

  if(FullName == ply:getDarkRPVar("rpname")) then

    net.Start("namenpc_message")
    net.WriteString("You can't name yourself the same thing!")
    net.Send(ply)

    // bLogs
    if(NameNPC.Config.bLogs.LogNPCUse == true) then

      if NameNPC.blogs then

        NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to change his name to " .. FullName .. " but was already called that.")

      end

    end

    return

  end

  if(ply:getDarkRPVar("money") < NameNPC.Config.Cost) then

    net.Start("namenpc_message")
    net.WriteString(NameNPC.Lang.Unaffordable)
    net.Send(ply)

    // bLogs
    if(NameNPC.Config.bLogs.LogNPCUse == true) then

      if NameNPC.blogs then

        NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " tried to change his name to " .. FullName .. " but couldn't afford it.")

      end

    end

    return

  end

  ply:addMoney(NameNPC.Config.Cost - (NameNPC.Config.Cost * 2))
  ply:SetNWString("PlayerName", FullName)
  ply:setDarkRPVar("rpname", FullName)

  net.Start("namenpc_message")
  net.WriteString(string.format(NameNPC.Lang.NameChanged, FullName))
  net.Send(ply)

  net.Start("namenpc_message")
  net.WriteString(string.format(NameNPC.Lang.MoneySpent, NameNPC.Config.Cost))
  net.Send(ply)

  // bLogs
  if(NameNPC.Config.bLogs.LogNPCUse == true) then

    if NameNPC.blogs then

      NameNPC.blogs:Log(bLogs:FormatPlayer(ply) .. " successfully changed his name to " .. FullName .. " paying $" .. NameNPC.Config.Cost .. ".")

    end

  end

  return

end)