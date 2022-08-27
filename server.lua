--================================--
--      txAdmin-Logs 1.0          --
--      by BreezyTheDev           --
--		GNU License v3.0		  --
--================================--

-- Warn
AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    Author = eventData.author
    Target = GetPlayerName(eventData.target)
    Reason = eventData.reason
    ActionID = eventData.actionId
    local ids = ExtractIdentifiers(eventData.target);
	local discord = ids.discord;  
    local gameLicense = ids.license;
    sendToDisc("Warn added via txAdmin by: "..Author, 
        "User: **"..Target.. "** \nReason: **"..Reason.."**\n Action ID: **"..ActionID.."**\nDiscord UID: **".. discord:gsub('discord:', '').."**\nDiscord Tag: <@".. discord:gsub('discord:', '').. "> \nGameLicense: **"..gameLicense.."**")
end)

-- Kick
AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    Author = eventData.author
    Target = n[eventData.target]
    Reason = eventData.reason
    local ids = ExtractIdentifiers(eventData.target);
	local discord = ids.discord;  
    sendToDisc("Kick added via txAdmin by: "..Author, 
    "User: **"..Target.. "** \nReason: **"..Reason.."**\n Discord UID: **".. discord:gsub('discord:', '').."**\nDiscord Tag: <@".. discord:gsub('discord:', '').. ">")
end)

-- Ban
AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    Author = eventData.author
    Target = GetPlayerName(eventData.target)
    Reason = eventData.reason
    ActionID = eventData.actionId
    Expiration = eventData.expiration
    local ids = ExtractIdentifiers(eventData.target);
	local discord = ids.discord;  
    local gameLicense = ids.license;
    if eventData.expiration == false then
        sendToDisc("Ban added via txAdmin by: "..Author, 
            "User: **"..Target.. "** \nReason: **"..Reason.."**\nDuration: **Permanent**\n Action ID: ** "..ActionID.."**\nDiscord UID: **".. discord:gsub('discord:', '').."**\nDiscord Tag: <@".. discord:gsub('discord:', '').. "> \nGameLicense: **"..gameLicense.."**")
    else
        sendToDisc("Temporary-Ban added via txAdmin by: "..Author, 
            "User: **"..Target.. "** \nReason: **"..Reason.."**\nDuration:** "..Expiration.. "\n**Action ID:** "..ActionID.."**\nDiscord UID: **".. discord:gsub('discord:', '').."**\nDiscord Tag: <@".. discord:gsub('discord:', '').. "> \nGameLicense: **"..gameLicense.."**")
    end
end)

-- Player Healed
AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
    Author = GetPlayerName(eventData.id)
    if eventData.id == -1 then
        sendToDisc("All Players Healed via txAdmin", 
         "All players was healed.")
    else
        sendToDisc("Player Healed via txAdmin", 
            "User: **"..Author.."** has been healed.")
    end
end)

-- Server Announcement
AddEventHandler('txAdmin:events:announcement', function(eventData)
    Author = eventData.author
    Message = eventData.message
    sendToDisc("Server Announcement via txAdmin by: "..Author, 
         "Message: ``".. Message.."``")
end)

-- Functions

function sendToDisc(title, msg)
    local embed = {}
    embed = {
        {
            ["color"] = 13055799,
            ["title"] = "**".. title .."**",
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "txAdmin Logs 1.0 by Breezy#0001",
            },
        }
    }
    PerformHttpRequest(Settings.txAdminLogs.Webhook,
    function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  -- END
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

-- Threads
n = {}
CreateThread(function()
	while true do
		Wait(1000)
		for k,v in pairs(GetPlayers()) do
			n[v] = GetPlayerName(v)
		end
	end
end)

if Settings.Debug.Toggle then
    if Settings.txAdminLogs.Webhook == '' then
        print("^1[txAdminLogs-DEBUG] In order for Discord Logs to work you must add a webhook..")
    end
end

-- Credits / Support
print("^0This resource was created by ^5Breezy#0001 ^0for support you can join his ^5discord: ^0https://discord.gg/zzUfkfRHzP")