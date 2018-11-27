/*
Thank you for downloading NameNPC. This is the config for the addon.
If you need any help or have a question goto livaco.tk and make a ticket on the dashboard. You will NOT get support anywhere else. Thanks!
*/

/*
General Settings
*/

// If the addon should use notifications instead of chat messages. I suggest using chat messages, as Notifications only come on for a limited time.
NameNPC.Config.UseNotifications = false

// Font to use for all of the addon's 3D2D and VGUI. Make sure it is installed on the server!
NameNPC.Config.Font = "Roboto"

// What the cost of renaming yourself is.
NameNPC.Config.Cost = 500

// If the script should check for blocked words
NameNPC.Config.CheckBlockedWords = true

// If above is true, what words are blocked. This will be check for both First Name and Last Name, and are not case sensitive.
NameNPC.Config.BlockedWords = {"Fuck", "Shit", "Bitch", "Piss", "Cock", "Pussy", "Bastard", "Slut", "Nigger"}

/*
Chat Settings
*/

// Only worry about this section if your using Notificatins instead of Chat Mesasges

// The prefix for all chat messages. I would suggest wrapping this in something like brackets or something.
NameNPC.Config.Prefix = "[NameNPC]"

// Color of the prefix. No need to specify an alpha value.
NameNPC.Config.PrefixColor = Color(0, 255, 0)

// Color of all the text after the prefix. I suggest keeping this white.
NameNPC.Config.TextColor = Color(255, 255, 255)

/*
NPC Settings
*/

// Model of the NPC.
NameNPC.Config.NPC.Model = "models/gman_high.mdl"

// If the 3D2D for the NPC should look at the player. If set to false, it will just face forward.
NameNPC.Config.NPC.Follow3D2D = true

// If there should be an outline on the 3D2D.
NameNPC.Config.NPC.Outlined3D2D = true

// If the NPC should reject certain ULX groups.
NameNPC.Config.NPC.BlockGroups = false

// If above is true, what groups to block.
NameNPC.Config.NPC.BlockedGroups = {"noaccess"}

// If the NPC should have a cooldown for using it.
NameNPC.Config.NPC.EnableCooldown = false

// If above is true, how long in seconds if the cooldown.
NameNPC.Config.NPC.Cooldown = 3

/*
bLogs Settings
*/

// Only worry about this is you have Billy's Logs - https://www.gmodstore.com/market/view/1599
// Also please not bLogs is only available in english, and cannot have it's text changed.

// If we should even enable bLogs support.
NameNPC.Config.bLogs.Enable = true

// Log when the NPC is used successfully.
NameNPC.Config.bLogs.LogNPCUse = true

// Log when the NPC is used but the player is in a blocked group.
NameNPC.Config.bLogs.LogNPCFailGroup = true

// Log when the NPC is used but the cooldown is in effect
NameNPC.Config.bLogs.LogNPCFailCool = true