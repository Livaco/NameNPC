function NameNPC:Message(msg)

  if(NameNPC.Config.UseNotifications == true) then

    notification.AddLegacy(msg, NOTIFY_GENERIC, 5)

  else

    chat.AddText(NameNPC.Config.PrefixColor, NameNPC.Config.Prefix, NameNPC.Config.TextColor, " ", msg)

  end

end

net.Receive("namenpc_message", function()

  NameNPC:Message(net.ReadString())

end)

net.Receive("namenpc_opengui", function()

  net.Start("namenpc_debugmsg")
  net.WriteString("Panel was opened and is attempting loading.")
  net.SendToServer()

  surface.CreateFont("namenpc_vgui1", {
    font = NameNPC.Config.Font,
    size = ScrH() * 0.025
  })

  surface.CreateFont("namenpc_vgui2", {
    font = NameNPC.Config.Font,
    size = ScrH() * 0.03
  })

  local frame = vgui.Create("DFrame")
  frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
  frame:SetTitle("")
  frame:Center()
  frame:MakePopup()
  frame:ShowCloseButton(false)
  frame.Paint = function(s, w, h)

    draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 255))
    draw.RoundedBox(0, 0, 0, w, h * 0.05, Color(0, 0, 0, 255))
    draw.SimpleText(NameNPC.Lang.VGUITitle, "namenpc_vgui1", w * 0.005, 0, Color(255, 255, 255, 255), 0, 0)

  end

  local HeaderPanel = vgui.Create("DPanel", frame)
  HeaderPanel:SetPos(frame:GetWide() * 0.025, frame:GetTall() * 0.075)
  HeaderPanel:SetSize(frame:GetWide() * 0.95, frame:GetTall() * 0.1)
  HeaderPanel.Paint = function(s, w, h)

    //draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 255))
    draw.SimpleText(string.format(NameNPC.Lang.VGUIHeader, NameNPC.Config.Cost), "namenpc_vgui2", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)

  end

  local FirstName = vgui.Create("DTextEntry", frame)
  FirstName:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.3)
  FirstName:SetSize(frame:GetWide() * 0.5, frame:GetTall() * 0.1)
  FirstName:SetPlaceholderText(NameNPC.Lang.VGUIFirstPlaceholder)
  FirstName:SetFont("namenpc_vgui1")

  local LastName = vgui.Create("DTextEntry", frame)
  LastName:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.5)
  LastName:SetSize(frame:GetWide() * 0.5, frame:GetTall() * 0.1)
  LastName:SetPlaceholderText(NameNPC.Lang.VGUILastPlaceholder)
  LastName:SetFont("namenpc_vgui1")

  local FirstNameHelp = vgui.Create("DLabel", frame)
  FirstNameHelp:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.25)
  FirstNameHelp:SetText(NameNPC.Lang.VGUIFirstHelp)
  FirstNameHelp:SetFont("namenpc_vgui1")
  FirstNameHelp:SizeToContents()

  local LastNameHelp = vgui.Create("DLabel", frame)
  LastNameHelp:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.45)
  LastNameHelp:SetText(NameNPC.Lang.VGUILastHelp)
  LastNameHelp:SetFont("namenpc_vgui1")
  LastNameHelp:SizeToContents()

  local SubmitButton = vgui.Create("DButton", frame)
  SubmitButton:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.7)
  SubmitButton:SetSize(frame:GetWide() * 0.225, frame:GetTall() * 0.1)
  SubmitButton:SetText("")
  SubmitButton.Paint = function(s, w, h)

    draw.RoundedBox(0, 0, 0, w, h, Color(0, 255, 0, 255))
    draw.SimpleText(NameNPC.Lang.VGUISubmit, "namenpc_vgui2", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)

  end
  SubmitButton.DoClick = function()

    net.Start("namenpc_submitname")
    net.WriteString(FirstName:GetValue())
    net.WriteString(LastName:GetValue())
    net.SendToServer()

    frame:Close()

  end

  local CancelButton = vgui.Create("DButton", frame)
  CancelButton:SetPos(frame:GetWide() * 0.525, frame:GetTall() * 0.7)
  CancelButton:SetSize(frame:GetWide() * 0.225, frame:GetTall() * 0.1)
  CancelButton:SetText("")
  CancelButton.Paint = function(s, w, h)

    draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 255))
    draw.SimpleText(NameNPC.Lang.VGUICancel, "namenpc_vgui2", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)

  end
  CancelButton.DoClick = function()

    frame:Close()

  end

end)