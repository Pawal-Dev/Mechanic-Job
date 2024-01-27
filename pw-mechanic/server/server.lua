if Config.framework == "newesx" then
	ESX = exports["es_extended"]:getSharedObject()
else
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                 
RegisterServerEvent('Ouverture:benny')
AddEventHandler('Ouverture:benny', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Entreprise', '~y~Benny\'s Motor Works', '~g~Ouverture~s~ du Benny\'s Motor Works', 'CHAR_CARSITE3')

	end
end)

RegisterServerEvent('Fermeture:benny')
AddEventHandler('Fermeture:benny', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Entreprise', '~y~Benny\'s Motor Works', '~r~Fermeture~s~ du Benny\'s Motor Works', 'CHAR_CARSITE3')
	end
end)


RegisterCommand('meca', function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer.job.name == Config.jobname then
      local src = source
      local msg = rawCommand:sub(5)
      local args = msg
      if player ~= false then
          local name = GetPlayerName(source)
          local xPlayers	= ESX.GetPlayers()
      for i=1, #xPlayers, 1 do
          local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Entreprise', '~y~Benny\'s Motor Works', msg, 'CHAR_CARSITE3')
		  logsmessage(xPlayer.getName(), msg, xPlayer.job.grade_label)
      end
  else
      TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_CARSITE3', 0)
  end
else
  TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_CARSITE3', 0)
end
end, false)

RegisterServerEvent('renfort:benny')
AddEventHandler('renfort:benny', function(coords)
	local _source = source
	local _raison = raison
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == Config.jobname then
			TriggerClientEvent('pawal:setBlip', xPlayers[i], coords)
		end
	end
end)

local function sendToDiscordWithSpecialURLDepotCoffre(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Benny's Motor Works | Gestion Interne",
	            },
	        }
	    }
	PerformHttpRequest(Config.webhook.DepotCoffre, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

local function sendToDiscordWithSpecialURLRetraitCoffre(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Benny's Motor Works | Gestion Interne",
	            },
	        }
	    }
	PerformHttpRequest(Config.webhook.RetraitCoffre, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

local function sendToDiscordWithSpecialURLLogs(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Benny's Motor Works | Gestion Interne",
	            },
	        }
	    }
	PerformHttpRequest(Config.webhook.logs, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

local function sendToDiscordWithSpecialURLMission(Color, Title, Description)
	local Content = {
		{
			["color"] = Color,
			["title"] = Title,
			["description"] = Description,
			["footer"] = {
			["text"] = "Benny's Motor Works | Gestion Interne",
			},
		}
	}
PerformHttpRequest(Config.webhook.Mission, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

local function sendToDiscordWithSpecialURLPatron(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Benny's Motor Works | Gestion Interne",
	            },
	        }
	    }
	PerformHttpRequest(Config.webhook.GestionPatron, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end


local function sendToDiscordWithSpecialURLPriseService(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Benny's Motor Works | Gestion Interne",
	            },
	        }
	    }
	PerformHttpRequest(Config.webhook.PriseService, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

local function sendToDiscordWithSpecialURLFinService(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Benny's Motor Works | Gestion Interne",
	            },
	        }
	    }
	PerformHttpRequest(Config.webhook.FinService, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('pawal:bennyinventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end

	cb(all_items)

end)

function logspatron(name, action, GradePlayer, color, somme)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end 
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	sendToDiscordWithSpecialURLPatron(color, "``📝`` Logs Patron\n\n``👨‍🔧`` Nom : "..name.."\n``📒`` Grade : "..GradePlayer.."\n``📌`` Action : "..action.." \n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min\n\n``💲`` Somme : "..somme..""..Config.Devise)
end

RegisterServerEvent("pawal:ActionMoneyMechanic")
AddEventHandler("pawal:ActionMoneyMechanic", function(accountData, moneyData, moneyCount, actionType)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xMoney = xPlayer.getMoney()
        if actionType == 1 then
                TriggerEvent('esx_addonaccount:getSharedAccount', accountData, function (account)
                    if xPlayer.getMoney() >= moneyCount then
                        account.addMoney(moneyCount)
                        xPlayer.removeMoney(moneyCount)
                        TriggerClientEvent("esx:showNotification", _src, "~g~Vous venez de déposé "..moneyCount.." "..Config.Devise)      
						logspatron(xPlayer.getName(), "Dépôt d'argent", xPlayer.job.grade_label, 32768, moneyCount)
                    else
                        TriggerClientEvent("esx:showNotification", _src, "~r~Il vous manque de l'argent")
                    end
                end)   
        elseif actionType == 2 then
            if moneyData >= moneyCount then
                TriggerEvent('esx_addonaccount:getSharedAccount', accountData, function (account)
                    if account.money >= moneyData then
                        account.removeMoney(moneyCount)
                        xPlayer.addMoney(moneyCount)
                        TriggerClientEvent("esx:showNotification", _src, "~r~Vous venez de retirer "..moneyCount.." "..Config.Devise)
						logspatron(xPlayer.getName(), "Retrait d'argent", xPlayer.job.grade_label, 16711680, moneyCount)
                    else
                        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d\'argent dans votre gestion!")
                    end
                end)
            end
        end
end)


ESX.RegisterServerCallback('pawal:récupérationstockitemsociety', function(source, cb)
	local societyitem = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_"..Config.jobname, function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(societyitem, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(societyitem)
end)

RegisterServerEvent('pawal:logs')
AddEventHandler('pawal:logs', function(action, GradePlayer, vehicleoption)
	local xPlayer = ESX.GetPlayerFromId(source)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end 
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	if vehicleoption == nil then
		sendToDiscordWithSpecialURLLogs(16777215, "``📝`` Logs Général\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``📙`` Grade : "..GradePlayer.."\n``📌`` Action : "..action.." \n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")
	else
		sendToDiscordWithSpecialURLLogs(16777215, "``📝`` Logs Général\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``📙`` Grade : "..GradePlayer.."\n``📌`` Action : "..action.." \n``🛻`` Vehicule : "..vehicleoption.."\n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")
	end
end)

RegisterServerEvent('pawal:missionlogs')
AddEventHandler('pawal:missionlogs', function(action, GradePlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end 
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	if vehicleoption == nil then
		sendToDiscordWithSpecialURLMission(16753920, "``📝`` Logs Mission\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``📙`` Grade : "..GradePlayer.."\n``📌`` Statut : "..action.." \n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")
	end
end)

function logsmessage(name, action, GradePlayer)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end 
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	sendToDiscordWithSpecialURLLogs(16777215, "``📝`` Logs Général\n\n``👨‍🔧`` Nom : "..name.."\n``📙`` Grade : "..GradePlayer.."\n``📌`` Action : Annonce Personnaliser \n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min\n\n``✏️`` Contenu : "..action)
end


RegisterServerEvent('pawal:priseservice')
AddEventHandler('pawal:priseservice', function(GradePlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end 
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	sendToDiscordWithSpecialURLPriseService(65280, "``🟢`` Prise de service\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``📗`` Grade : "..GradePlayer.."\n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")
end)

RegisterServerEvent('pawal:finservice')
AddEventHandler('pawal:finservice', function(GradePlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	sendToDiscordWithSpecialURLFinService(16711680, "``🔴`` Fin de service\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``📕`` Grade : "..GradePlayer.."\n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")
end)

RegisterServerEvent('pawal:depotbenny')
AddEventHandler('pawal:depotbenny', function(itemName, count, GradePlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_"..Config.jobname, function(inventory)
        local inventoryItem = inventory.getItem(itemName)

		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous venez de déposer x"..count.." "..inventoryItem.label..' dans le coffre')
			sendToDiscordWithSpecialURLDepotCoffre(65280, "``🟢`` Dépôt Coffre\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``📗`` Grade : "..GradePlayer.."\n``📌`` Objet : "..inventoryItem.label.."\n``📦`` Quantité : x"..count.."\n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'en avez pas assez sur vous")
		end
	end)
end)

RegisterServerEvent('pawal:retraitbenny')
AddEventHandler('pawal:retraitbenny', function(itemName, count, GradePlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_"..Config.jobname, function(inventory)
        local inventoryItem = inventory.getItem(itemName)

			xPlayer.addInventoryItem(itemName, count)
			inventory.removeItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous venez de retirer x"..count.." "..inventoryItem.label.." du coffre")
			sendToDiscordWithSpecialURLRetraitCoffre(16711680, "``🔴`` Retrait Coffre\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``📕`` Grade : "..GradePlayer.."\n``📌`` Objet : "..inventoryItem.label.."\n``📦`` Quantité : x"..count.."\n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")

	end)
end)

RegisterServerEvent('pawal:farmitem')
AddEventHandler('pawal:farmitem', function(item)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, 1)    
end)

ESX.RegisterServerCallback('pawal:checkitem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getInventoryItem(item).count)
end)

RegisterServerEvent('pawal:craftkitreparation')
AddEventHandler('pawal:craftkitreparation', function(nombrekit)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem("repairkit", nombrekit)   
	xPlayer.removeInventoryItem("ferraille", Config.Etabli.ferraillerequis * nombrekit)     
	xPlayer.removeInventoryItem("acier", Config.Etabli.acierrequis *nombrekit)     
end)

RegisterServerEvent('pawal:verifkitnettoyage')
AddEventHandler('pawal:verifkitnettoyage', function(nombrekit)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local balance = xPlayer.getMoney() 
	local somme = tonumber(Config.Etabli.pricekitnettoyage * nombrekit)

	if balance >= somme then
	    xPlayer.removeMoney(somme)
		TriggerClientEvent('pawal:startcraftnettoyage', source, nombrekit)
    else
		TriggerClientEvent('esx:showAdvancedNotification', source, 'Avertisement', '~r~Erreur' , '~r~Vous n\'avez pas assez d\'argent sur vous', 'CHAR_CARSITE3', 0)
	end
end)

RegisterServerEvent('pawal:verifkitreparation')
AddEventHandler('pawal:verifkitreparation', function(nombrekit)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local balance = xPlayer.getMoney() 
	local somme = tonumber(Config.Etabli.pricekitreparation * nombrekit)

	if balance >= somme then
	    xPlayer.removeMoney(somme)
		TriggerClientEvent('pawal:startcraftreparation', source, nombrekit)
    else
		TriggerClientEvent('esx:showAdvancedNotification', source, 'Avertisement', '~r~Erreur' , '~r~Vous n\'avez pas assez d\'argent sur vous', 'CHAR_CARSITE3', 0)
	end
end)

RegisterServerEvent('pawal:craftkitreparationpaid')
AddEventHandler('pawal:craftkitreparationpaid', function(nombrekit)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem("repairkit", nombrekit)     
end)

RegisterServerEvent('pawal:missionreussimayement')
AddEventHandler('pawal:missionreussimayement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..Config.jobname, function(account)
		account.addMoney(total)
	end)

	TriggerClientEvent('esx:showAdvancedNotification', _source, '~y~Notification', '~y~Benny\'s Motor Works', "Vous venez de faire gagner ~y~"..total.."$~s~ à l'entreprise", 'CHAR_CARSITE3')
end)

if Config.userepairkit then
	ESX.RegisterUsableItem('repairkit', function(source)
		local _source = source
		local xPlayer  = ESX.GetPlayerFromId(source)

		xPlayer.removeInventoryItem('repairkit', 1)

		TriggerClientEvent('pawal:utilisationkitreparation', _source)
	end)
end

if Config.usecleankit then
	ESX.RegisterUsableItem('cleankit', function(source)
		local _source = source
		local xPlayer  = ESX.GetPlayerFromId(source)

		xPlayer.removeInventoryItem('cleankit', 1)

		TriggerClientEvent('pawal:utilisationkitnettoyage', _source)
	end)
end

RegisterServerEvent("pawal:recruterjoueurmechanic")
AddEventHandler("pawal:recruterjoueurmechanic", function(target)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local xTarget = ESX.GetPlayerFromId(target)
		xTarget.setJob(xPlayer.job.name, 0)
		MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
			["identifier"] = xTarget.identifier,
			["job"] = Config.jobname,
			["job_grade"] = 0
		})

		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['identifier'] = xTarget.identifier
		}, function(data)
			for _,v in pairs(data) do
			   nametarget = v.firstname.." "..v.lastname
			end
		end)

		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['identifier'] = xPlayer.identifier
		}, function(data)
			for _,v in pairs(data) do
			   nametxplayer = v.firstname.." "..v.lastname
			end
		end)

		TriggerClientEvent('esx:showNotification', source, "Vous avez ~r~recruté " .. nametarget)
		TriggerClientEvent('esx:showNotification', target, "Vous avez été ~r~recruté par " .. nametxplayer)
end)

RegisterServerEvent("pawal:virerjoueurmechanic")
AddEventHandler("pawal:virerjoueurmechanic", function(target)
local _src = source
local xPlayer = ESX.GetPlayerFromId(_src)
local xTarget = ESX.GetPlayerFromId(target)
	if xTarget.getJob().name == xPlayer.getJob().name then 
		xTarget.setJob("unemployed", 0)
		MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
			["identifier"] = xTarget.identifier,
			["job"] = "unemployed",
			["job_grade"] = 0
		})

		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['identifier'] = xTarget.identifier
		}, function(data)
			for _,v in pairs(data) do
			   nametarget = v.firstname.." "..v.lastname
			end
		end)

		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['identifier'] = xPlayer.identifier
		}, function(data)
			for _,v in pairs(data) do
			   nametxplayer = v.firstname.." "..v.lastname
			end
		end)     

		TriggerClientEvent('esx:showNotification', source, "~r~Vous avez licencié "..nametarget)
		TriggerClientEvent('esx:showNotification', target, "~r~Vous avez été licencié par "..nametxplayer)
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez pas licencier un joueur n'étant pas dans la LSPD..")
end
end)

ESX.RegisterServerCallback("pawal:getgrademechanic", function(source, cb)
    local gradeselection = {}
  
    MySQL.Async.fetchAll("SELECT * FROM job_grades WHERE job_name = @job_name", {['job_name'] = Config.jobname}, function(data)
        for _,v in pairs(data) do
        table.insert(gradeselection, {
          gradeID = v.id,
          gradeJob = tonumber(v.grade),
          gradeLabel = v.label,
          gradeName = v.name,
          gradeSalaire = v.salary
        })
        end

        cb(gradeselection)
    end)
end)

RegisterServerEvent("pawal:editgrademechanic")
AddEventHandler("pawal:editgrademechanic", function(values, jobnames, gradetype)
        MySQL.Async.execute("UPDATE job_grades SET `salary` = @salary WHERE `grade` = @grade AND `job_name` = @job_name",{
            ['@job_name'] = jobnames,
            ['@grade'] = gradetype,
            ['@salary'] = values
        })  
end)


ESX.RegisterServerCallback("pawal:getplayermechanicjob", function(source, cb)
    local users = {}
    MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job", {
        ['job'] = Config.jobname
    }, function(data)
        for _,v in pairs(data) do
        table.insert(users, {
          firstname = v.firstname,
          lastname = v.lastname,
          job = v.job,
          grade = v.job_grade, 
          identifier = v.identifier
        })
        end
        cb(users)
    end)
end)

ESX.RegisterServerCallback("pawal:getmoneymechanic", function(source, cb, society)
    MySQL.Async.fetchAll('SELECT money FROM addon_account_data WHERE account_name = @account_name', {
        ['account_name'] = "society_"..Config.jobname
    }, function(data)
        for k, v in pairs(data) do
            getmoney = v.money
         end
        cb(getmoney)
  end)
end)

ESX.RegisterServerCallback("pawal:recuperationplayerlistlspd", function(source, cb)
    local users = {}
    MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job", {
        ['job'] = Config.jobname
    }, function(data)
        for _,v in pairs(data) do
        table.insert(users, {
          firstname = v.firstname,
          lastname = v.lastname,
          job = v.job,
          grade = v.job_grade, 
          identifier = v.identifier
        })
        end
        cb(users)
    end)
end)

RegisterServerEvent("pawal:promouvoirplayer")
AddEventHandler("pawal:promouvoirplayer", function(identifier, job, gradeid, gradename, name)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    local identifierplayer = xPlayer.getIdentifier()

    if identifierplayer ~= identifier then
    MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
        ["identifier"] = identifier,
        ["job"] = job,
        ["job_grade"] = gradeid
    })
    if xTarget ~= nil then 
        xTarget.setJob(job, gradeid)
    end
        TriggerClientEvent("esx:showNotification", _src, "~g~Vous venez de modifier "..name.." au grade de "..gradename)   
    
    else
        TriggerClientEvent("esx:showNotification", _src, "~r~Vous ne pouvez pas vous promouvoir vous-même")   
    end
end)