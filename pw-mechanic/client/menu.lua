--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                 
local proxiveh = nil
local lock = false 
local interactionmessage = nil
local Chargement = nil
local Percentage = 0.0
local repairaction, cleanaction, refuelaction, impoundaction = false, false, false, false
local texteprogress = "Non défini"
local performanceactivation = true
local diagnostiqueactivation = true
local vehicles = {}
local selectVeh = nil
local vehProps = nil
local fait = false
local faitt = false
local encours = true
local NPCOnJob = false

local statsVeh = {{
    mod = 'modEngine',
    label = "Moteur"
}, {
    mod = 'modTransmission',
    label = "Transmission"
}, {
    mod = 'modBrakes',
    label = "Frein"
}, {
    mod = 'modSuspension',
    label = "Suspension"
}}

if Config.Etabli.payforcraft then
    categorielist = {"~g~Citoyen~s~", "~g~Véhicule~s~", "~g~Mission~s~"}
else
    categorielist = {"~g~Citoyen~s~", "~g~Véhicule~s~", "~g~Mission~s~", "~g~Farm~s~"}
end
categorielistIndex = 1

local AnnonceList = {
    "~g~Ouverture~s~",
    "~r~Fermeture~s~",
    "~b~Personnaliser~s~"
}

local AnnonceListIndex = 1
              
 
 local mainMenu = RageUI.CreateMenu("MECANO", "Action") 
 local communication = RageUI.CreateSubMenu(mainMenu, "Communication", "Action")
 local MenuDiagnostique = RageUI.CreateSubMenu(mainMenu, "Benny's", "Action") 
 local performance = RageUI.CreateSubMenu(MenuDiagnostique, "Benny's", "Action")
 local diagnostique = RageUI.CreateSubMenu(MenuDiagnostique, "Benny's", "Action")
 local open = false
 
 mainMenu.X = 0 
 mainMenu.Y = 0
 
 mainMenu.Closed = function() 
     open = false 
 end 

 function menumechanic()
     if open then 
         open = false 
             RageUI.Visible(mainMenu, false) 
             return 
     else 
         open = true 
         local fait = false
             RageUI.Visible(mainMenu, true)
         Citizen.CreateThread(function()
             while open do 
                if RageUI.Visible(performance) or RageUI.Visible(diagnostique) or RageUI.Visible(MenuDiagnostique) then
                    if GetClosestVehicle(GetEntityCoords(PlayerPedId()),3.0, 0, 70) <= 4.0 then
                    ESX.ShowNotification('~r~Vous êtes trop loin du véhicule')
                    RageUI.Visible(mainMenu, true)
                    end
                end
                 RageUI.IsVisible(mainMenu, function()
                    if service == true then
                    proxiveh = ESX.Game.GetVehicleInDirection()
                    playerPed = PlayerPedId()

                    RageUI.List("Catégorie", categorielist, categorielistIndex, nil, {}, true, {
                        onActive = function()
                            activee = false
                        end,
                        onListChange = function(i, Items)
                            if categorielistIndex ~= i then
                                categorielistIndex = i;
                            end
                        end,
                        onSelected = function()
                        end
                    }) 

                    RageUI.line(255,255,255,255)

                    if categorielistIndex == 1 then
                        RageUI.Button("Communication", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                            end
                        }, communication)

                        RageUI.Button("Facturation", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                local ClosestPlayer, distance = ESX.Game.GetClosestPlayer()
                                local montant =  KeyboardInput("Montant de la facture", "", 100)
                                montant = tonumber(montant)
                                if Config.useothersystem == false then
                                    facture(montant)
                                else
                                    Config.facturecustom(montant)
                                end
                            end
                        })                  
                    end
                    
                    if categorielistIndex == 2 then

                        if DoesEntityExist(proxiveh) then
                            lock = true 
                            interactionmessage = nil
                        else
                            lock = false
                            interactionmessage = "~r~Aucun véhicule à proximité"
                        end

                        RageUI.Button("Réparation Véhicule", interactionmessage, {RightLabel = "→→"}, lock, {
                            onActive = function()
                                GetCloseVehi()
                            end,
                            onSelected = function()
                                if Config.progressbar == false then
                                    texteprogress = "Réparation en cours ..."
                                    repairaction = true
                                    Chargement = true             
                                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)     
                                else
                                    repaircar(false)
                                end          
                            end
                        })

                        RageUI.Button("Nettoyage Véhicule", interactionmessage, {RightLabel = "→→"}, lock, {
                            onActive = function()
                                GetCloseVehi()
                            end,
                            onSelected = function()
                                if Config.progressbar == false then
                                    texteprogress = "Nettoyage en cours ..."
                                    cleanaction = true
                                    Chargement = true       
                                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                                else
                                    cleancar(false)
                                end     
                            end
                        })

                        RageUI.Button("Mettre le plein d'essence", interactionmessage, {RightLabel = "→→"}, lock, {
                            onActive = function()
                                GetCloseVehi()
                            end,
                            onSelected = function()
                                if Config.progressbar == false then
                                    texteprogress = "Remplissage en cours ..."
                                    refuelaction = true
                                    Chargement = true   
                                    TaskPlayAnim(playerPed, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                                else
                                    refuelcar(false)
                                end   
                            end
                        })

                        RageUI.Button("Mettre en fourrière", interactionmessage, {RightLabel = "→→"}, lock, {
                            onActive = function()
                                GetCloseVehi()
                            end,
                            onSelected = function()
                                if Config.progressbar == false then
                                    texteprogress = "Mise en fourrière en cours ..."
                                    impoundaction = true
                                    Chargement = true    
                                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)                   
                                else
                                    impoundcar(false)
                                end  
                            end
                        })
                        
                        RageUI.Button("Mettre / Retirer le véhicule du plateau", "~b~Information\n~s~Vous devez d'abord monter dans votre dépanneuse à plateau", {RightLabel = "→→"}, lock, {
                            onActive = function()
                                GetCloseVehi()
                              end,
                            onSelected = function()
                                plateau()
                            end
                        })
        
                        
                        RageUI.Button("Caractéristique / Diagnostique Véhicule", messagediagno, {RightLabel = "→→"}, lock, {
                            onActive = function()
                                GetCloseVehi()
                            end,
                            onSelected = function()
                            end
                           }, MenuDiagnostique)
                        Percentage = Percentage + 0.0015

                        if Chargement == true then
                            RageUI.PercentagePanel(Percentage, texteprogress.." (~r~"..math.floor(Percentage*100).."%~s~)", "", "", {})
                    
                            if Percentage < 1.0 then
                                if impoundaction == false then
                                    Percentage = Percentage + 0.0011
                                else
                                    Percentage = Percentage + 0.0015
                                end
                            else 
                                Percentage = 0
                            end
            
                            if Percentage >= 1.0 then
                                local vehicle = ESX.Game.GetVehicleInDirection()
                                local plate = GetVehicleNumberPlateText(vehicle)
                                local playerPed = PlayerPedId()
                                ClearPedTasks(playerPed)
                                if repairaction then
                                    repaircar()
                                elseif cleanaction then
                                    cleancar()
                                elseif refuellaction then
                                    refuelcar()
                                elseif impoundaction then
                                    impoundcar()
                                end

                                repairaction, cleanaction, refuelaction, impoundaction = false, false, false, false
                                Chargement = false
                                Percentage = 0.0
                                mainMenu.Closable = true
                            end
                        end
                    end

                    if categorielistIndex == 3 then
                        local vehiclemission = GetVehiclePedIsIn(PlayerPedId(), false)
                        local model = GetEntityModel(vehiclemission)
                        local displaytext = GetDisplayNameFromVehicleModel(model)
                
                        if displaytext == "FLATBED" then
                           autorisation = true 
                           message = nil
                        else
                           autorisation = false 
                           message = "~r~Bloquer\n~s~Vous devez être à bord d'une Dépanneuse à plateau pour commencer une mission"
                        end
        
                        if Config.MissionPnj and NPCOnJob == true then
                            RageUI.Separator("En Mission : ~g~Oui~s~")
                            RageUI.Separator("Objectif : ~y~"..objectif.."~s~")
                            RageUI.line(255,255,255,255)
                        elseif Config.MissionPnj and NPCOnJob == false then
                            RageUI.Separator("En Mission : ~r~Non~s~")
                            RageUI.line(255,255,255,255)
                        end

                        if NPCOnJob == false then
                            RageUI.Button("Commencer une mission", message, {RightLabel = "→→"}, autorisation, {
                             onSelected = function()
                                 NPCOnJob = true
                                 objectif = "Récupérer le véhicule"
                                 StartNPCJob()
                             end
                            })
                         elseif NPCOnJob == true then
                             RageUI.Button("Annuler la mission", nil, {RightLabel = "→→"}, true, {
                                 onSelected = function()
                                     NPCOnJob = false
                                     StopNPCJob(true)
                                 end
                             })
                         end
                    end

                    if categorielistIndex == 4 then
                        RageUI.Button("~r~Supprimer l'ininéraire du GPS", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                setWaypoint('none')
                            end
                        }) 
                        RageUI.Button("Point de farm ferraille", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                setWaypoint('feraille')
                            end
                        }) 

                        RageUI.Button("Point de farm acier", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                setWaypoint('acier')
                            end
                        }) 
                    end

                else
                    RageUI.Separator('')
                    RageUI.Separator('~r~Vous n\'êtes pas en service')
                    RageUI.Separator('')
                end

            end)

            RageUI.IsVisible(communication, function()
                    RageUI.Button("Demande Assistance", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        local coords  = GetEntityCoords(playerPed)
                        TriggerServerEvent('renfort:benny', coords)
                    end
                })
                RageUI.List("Annonce", AnnonceList, AnnonceListIndex, nil, {}, true, {
                    onListChange = function(i, Items)
                        if AnnonceListIndex ~= i then
                            AnnonceListIndex = i;
                        end
                    end,
                    onSelected = function(i, itm)
                        if i == 1 then
                            TriggerServerEvent('Ouverture:benny')
                        elseif i == 2 then
                            TriggerServerEvent('Fermeture:benny')
                        elseif i == 3 then
                            local message = KeyboardInput("Texte de l'annonce", "", 100)
                            if message ~= nil and message ~= "" then
                                ExecuteCommand("meca " ..message)
                            end
                        end
                    end
                })
            end)

            RageUI.IsVisible(MenuDiagnostique, function()
                fait = false
                faitt = false
                local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()),3.0, 0, 70)
                local model = GetEntityModel(veh)
                local displaytext = GetDisplayNameFromVehicleModel(model)
                local text = GetLabelText(displaytext)
                RageUI.Separator('Modèle du véhicule : ~b~'..text)
                RageUI.Separator('Plaque : ~b~'..GetVehicleNumberPlateText(veh))
                RageUI.line(255,255,255,255)
                RageUI.Button("Performance", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        local veh, dst = ESX.Game.GetClosestVehicle(playerCoords)
                        if dst <= 2.5 then
                            vehProps = ESX.Game.GetVehicleProperties(veh)
                        end
                    end
                   },performance)
                RageUI.Button("Diagnostique", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                    end
                   }, diagnostique)
            end)

            RageUI.IsVisible(performance, function()
                local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()),3.0, 0, 70)
                local model = GetEntityModel(veh)
                local displaytext = GetDisplayNameFromVehicleModel(model)
                local text = GetLabelText(displaytext)
                MaxSpeed = GetVehicleModelMaxSpeed(GetHashKey(model))*3.6
                Acceleration = GetVehicleModelAcceleration(GetHashKey(model))*3.6/220
                Braking = GetVehicleModelMaxBraking(GetHashKey(model))/2
                RageUI.Separator('Modèle du véhicule : ~b~'..text)
                RageUI.Separator('Plaque : ~b~'..GetVehicleNumberPlateText(veh))
                RageUI.line(255,255,255,255)
                if faitt == false then
                RageUI.Button("Vérifier les performances", nil, {RightLabel = "→→"}, performanceactivation, {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        performance.Closable = false
                        performanceactivation = false
                        if Config.progressbar == true then
                            Config.customprogressbar(6000, "Vérification en cours...")
                        else
                            ESX.ShowNotification('~g~Vérification en cours...')
                            Wait(6000)
                        end
                        ClearPedTasks(playerPed)
                        performanceactivation = true
                        performance.Closable = true
                        faitt = true
                    end
                   })
                end
                if faitt == true then
                if not vehProps then
                    RageUI.Separator("Pas de vehicule à proximité")
                else
                    for kStatsVeh, vStatsVeh in pairs(statsVeh) do
                        RageUI.Separator(vStatsVeh.label .. ":  ~g~Stage " .. vehProps[vStatsVeh.mod] + 2)
                    end
                    RageUI.Separator("Turbo: " .. (vehProps["modTurbo"] and "~g~Installé" or "~r~Pas installé"))
                end
            end
            end)

            RageUI.IsVisible(diagnostique, function()
                local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()),3.0, 0, 70)
                local model = GetEntityModel(veh)
                local displaytext = GetDisplayNameFromVehicleModel(model)
                local text = GetLabelText(displaytext)
                RageUI.Separator('Modèle du véhicule : ~b~'..text)
                RageUI.Separator('Plaque : ~b~'..GetVehicleNumberPlateText(veh))
                RageUI.line(255,255,255,255)

                if fait == false then
                RageUI.Button("Lancer un diagnostique", nil, {RightLabel = "→→"}, diagnostiqueactivation, {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        diagnostiqueactivation = false
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        diagnostique.Closable = false
                        if Config.progressbar == true then
                            Config.customprogressbar(6000, "Diagnostique en cours...")
                        else
                            ESX.ShowNotification('~g~Diagnostique en cours...')
                            Wait(6000)
                        end
                        ClearPedTasks(playerPed)
                        diagnostiqueactivation = true
                        diagnostique.Closable = true
                        fait = true
                    end
                   })
                end

                if fait == true then
                    RageUI.Separator('Etat du véhicule : ~g~'..Round(GetVehicleEngineHealth(veh)).."~s~ /1000")
                    RageUI.Separator("Essence : ~o~"..Round(GetVehicleFuelLevel(veh)).." L")
                    RageUI.line(255,255,255,255)
                    RageUI.Separator("↓ ~b~Résultat du diagnostique~s~ ↓")
                    if Round(GetVehicleEngineHealth(veh)) >= 700 then
                    RageUI.Separator("Véhicule en ~g~Bonne état")
                    elseif Round(GetVehicleEngineHealth(veh)) >= 400 then
                        RageUI.Separator("Véhicule en ~o~Assez bonne état")
                    elseif Round(GetVehicleEngineHealth(veh)) < 400 then
                        RageUI.Separator("Véhicule en ~r~Mauvaise état")
                 end
                end

            end)

        
             Wait(0)
             end
         end)
     end
 end
 
 -- MARKERS
 
 Keys.Register('F6', 'pw_mechanic', 'Ouvrir le menu mécano', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname then
        menumechanic()
	end
end)


Citizen.CreateThread(function()
     local MECHANICBLIP = AddBlipForCoord(Config.blipposition)

      SetBlipSprite(MECHANICBLIP, Config.blipsprite)
      SetBlipColour(MECHANICBLIP, Config.blipcolour)
      SetBlipScale(MECHANICBLIP, Config.blipscale)
      SetBlipAsShortRange(MECHANICBLIP, true)
      BeginTextCommandSetBlipName('STRING')
      AddTextComponentSubstringPlayerName(Config.blipname) 
      EndTextCommandSetBlipName(MECHANICBLIP)

end)
