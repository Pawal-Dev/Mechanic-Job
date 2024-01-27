function repaircar(usetarget)
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~r~Vous ne pouvez pas faire cette action depuis un véhicule", 'CHAR_CARSITE3', 1)
        return
    end

    if DoesEntityExist(vehicle) then
        isBusy = true
        Citizen.CreateThread(function()
            if Config.progressbar == true then
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                Config.customprogressbar(10000, "Réparation...")
            end

            if Config.progressbar == false then
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                ESX.ShowNotification('~g~Réparation en cours ...')
                Wait(10000)
            end

            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            ClearPedTasks(playerPed)
            TriggerServerEvent('pawal:logs', "Réparation" ,ESX.PlayerData.job.grade_label)
            ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~g~Réparation du véhicule réussi", 'CHAR_CARSITE3', 1)
            isBusy = false
        end)
    else
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~r~Aucun véhicule à proximité", 'CHAR_CARSITE3', 1)
    end
end

function plateau()
    local vehicledepannage =  GetClosestVehicle(GetEntityCoords(PlayerPedId()),5.0, 0, 70)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, true)

    local towmodel = GetHashKey('flatbed')
    local isVehicleTow = IsVehicleModel(vehicle, towmodel)

    if isVehicleTow then

        if CurrentlyTowedVehicle == nil then
            if DoesEntityExist(vehicledepannage) then
                if not IsPedInAnyVehicle(playerPed, true) then
                    if vehicle ~= vehicledepannage then
                        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                        encours = false
                        if Config.progressbar == true then
                            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            Config.customprogressbar(10000, "Mise sur le plateau...")
                        end
            
                        if Config.progressbar == false and usetarget == true then
                            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            ESX.ShowNotification('~g~Mise sur le plateau en cours ...')
                            Wait(10000)
                        end
                        encours = true
                        ClearPedTasks(playerPed)
                        AttachEntityToEntity(vehicledepannage, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                        CurrentlyTowedVehicle = vehicledepannage
                        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~g~Mise sur le plateau réussi", 'CHAR_CARSITE3', 1)

                        if NPCOnJob then
                            if NPCTargetTowable == vehicledepannage then
                                objectif = "Déposer le véhicule au garage"
                                ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "Dés à présent, Déposer le ~y~véhicule au garage~s~", 'CHAR_CARSITE3', 1)
                                Config.Zones.VehicleDelivery.Type = 1

                                if Blips['NPCTargetTowableZone'] then
                                    RemoveBlip(Blips['NPCTargetTowableZone'])
                                    Blips['NPCTargetTowableZone'] = nil
                                end

                                Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
                                SetBlipRoute(Blips['NPCDelivery'], true)
                            end
                        end
                    else
                        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~r~Vous ne pouvez pas attacher votre véhicule de dépannage", 'CHAR_CARSITE3', 1)
                    end
                end
            else
                ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~r~Aucun véhicule à proximité", 'CHAR_CARSITE3', 1)
            end
        else
            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
            DetachEntity(CurrentlyTowedVehicle, true, true)
            
            if NPCOnJob then
                if NPCTargetDeleterZone then

                    if CurrentlyTowedVehicle == NPCTargetTowable then
                        ESX.Game.DeleteVehicle(NPCTargetTowable)
                        TriggerServerEvent('pawal:missionreussimayement')
                        TriggerServerEvent('pawal:missionlogs', "Fin de mission (réussi)" ,ESX.PlayerData.job.grade_label)
                        PlaySoundFrontend(-1, Mission_Pass_Notify, DLC_HEISTS_GENERAL_FRONTEND_SOUNDS)
                        StopNPCJob()
                        NPCTargetDeleterZone = false
                    else
                        ESX.ShowNotification("Ce n'est pas le bon ~r~véhicule !", 'CHAR_CARSITE3')
                    end

                else
                    ESX.ShowNotification("Vous n'etes pas au bon endroit ~h~pour faire cela !")
                end
            end

            CurrentlyTowedVehicle = nil
            ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~g~Véhicule retirer du plateau", 'CHAR_CARSITE3', 1)
        end
    else
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~r~Vous devez avoir un véhicule à plateau pour faire cela", 'CHAR_CARSITE3', 1)
    end
end

function cleancar(usetarget)
    local playerPed = PlayerPedId()
    
    local vehicle   = ESX.Game.GetVehicleInDirection()

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('~r~Vous ne pouvez pas faire cette action depuis un véhicule')
        return
    end

    if DoesEntityExist(vehicle) then
        FreezeEntityPosition(playerPed, true)
        if Config.progressbar == true then
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
            Config.customprogressbar(6000, "Nettoyage...")
        end

        if Config.progressbar == false then
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
            ESX.ShowNotification('~g~Nettoyage en cours ...')
            Wait(10000)
        end
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~g~Nettoyage réussi", 'CHAR_CARSITE3', 1)
        SetVehicleDirtLevel(vehicle, 0.0)
        FreezeEntityPosition(playerPed, false)
        ClearPedTasks(playerPed)
        TriggerServerEvent('pawal:logs', "Nettoyage" ,ESX.PlayerData.job.grade_label)

    else
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~r~Aucun véhicule à proximité", 'CHAR_CARSITE3', 1)
    end
end

function refuelcar(usetarget)
    LoadAnimDict("timetable@gardener@filling_can")
                            
    local playerPed = PlayerPedId()

    local vehicle   = ESX.Game.GetVehicleInDirection()

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('~r~Vous ne pouvez pas faire cette action depuis un véhicule')
        return
    end
    if DoesEntityExist(vehicle) then
        FreezeEntityPosition(playerPed, true)
        if Config.progressbar == true then
            TaskPlayAnim(playerPed, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
            Config.customprogressbar(6000, "Remplissage du réservoir...")
        end

        if Config.progressbar == false then
            TaskPlayAnim(playerPed, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
            ESX.ShowNotification('~g~Remplissage du réservoir en cours ...')
            Wait(10000)
        end
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~g~Plein du réservoir réussi", 'CHAR_CARSITE3', 1)
        Config.essencefunction(100.0)
        FreezeEntityPosition(playerPed, false)
        ClearPedTasks(playerPed)
        TriggerServerEvent('pawal:logs', "Remplissage Réservoir" ,ESX.PlayerData.job.grade_label)
    else
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification', "~r~Aucun véhicule à proximité", 'CHAR_CARSITE3', 1)
    end
end

function impoundcar(usetarget)
    local playerPed = PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    local plate = GetVehicleNumberPlateText(vehicle)

    if DoesEntityExist(vehicle) then
        if Config.progressbar == true then
            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
            Config.customprogressbar(10000, "Mise en fourrière en cours...")
        end

        if Config.progressbar == false then
            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
            ESX.ShowNotification('~g~Mise en fourrière en cours ...')
            Wait(10000)
        end              
        
        local vehicle = ESX.Game.GetVehicleInDirection()
        local plate = GetVehicleNumberPlateText(vehicle)
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        ESX.ShowNotification('~g~Vous venez de mettre en fourrière le véhicule immatriculer '..plate)
        ESX.Game.DeleteVehicle(vehicle) 
        TriggerServerEvent('pawal:logs', "Mise en fourrière" ,ESX.PlayerData.job.grade_label)
    else
        ESX.ShowNotification('~r~Aucun véhicule à proximité')
    end
end

function facture(price)
    local ClosestPlayer, distance = ESX.Game.GetClosestPlayer()
    if ClosestPlayer ~= -1 and distance <= 3.0 then
        if price ~= nil and type(price) == 'number' then
            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
              Citizen.Wait(4000)
              ClearPedTasks(PlayerPedId())
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(ClosestPlayer), 'society_mechanic', 'Benny\'s Motor Work', price)
                ESX.ShowNotification("~g~Vous avez envoyée une facture au montant de "..price.."$")
        else
            ESX.ShowNotification("~r~Montant invalide")
        end
    else
        ESX.ShowNotification("~r~Aucun joueur à proximité")
    end
end

function startfarmferraille()
    Citizen.CreateThread(function()
        while farmencoursferaille == true do
            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true) 
            if Config.progressbar == true then  
                Config.customprogressbar(2000, "Récolte en cours ...")
            else
                Citizen.Wait(2000)
            end
            ClearPedTasks(playerPed)
            ClearPedSecondaryTask(playerPed)
            TriggerServerEvent('pawal:farmitem', 'ferraille') 
            Citizen.Wait(0)
        end
    end)
end

function recolteferraille()
    local playerPed = GetPlayerPed(-1)
    if not farmencoursferaille then
        farmencoursferaille = true
        FreezeEntityPosition(playerPed, true)
        startfarmferraille()
    else
        farmencoursferaille = false
        FreezeEntityPosition(playerPed, false)
        Wait(200)
        ClearPedTasks(playerPed)
        ClearPedSecondaryTask(playerPed)
    end
end

function startfarmacier()
    Citizen.CreateThread(function()
        while farmencoursacier == true do
            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true) 
            if Config.progressbar == true then  
                Config.customprogressbar(2000, "Récolte en cours ...")
            else
                Citizen.Wait(2000)
            end
            ClearPedTasks(playerPed)
            ClearPedSecondaryTask(playerPed)
            TriggerServerEvent('pawal:farmitem', 'acier') 
            Citizen.Wait(0)
        end
    end)
end

function recolteacier()
    local playerPed = GetPlayerPed(-1)
    if not farmencoursacier then
        farmencoursacier = true
        FreezeEntityPosition(playerPed, true)
        startfarmacier()
    else
        farmencoursacier = false
        FreezeEntityPosition(playerPed, false)
        Wait(200)
        ClearPedTasks(playerPed)
        ClearPedSecondaryTask(playerPed)
    end
end

function startcraft(nombreCraft)
    local playerPed = GetPlayerPed(-1)
    if Config.progressbar == true then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        Config.customprogressbar(2000*nombreCraft, "Craft en cours...")
    end

    if Config.progressbar == false then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        ESX.ShowNotification('~g~Craft en cours ...')
        Wait(2000*nombreCraft)
    end
    ClearPedTasks(playerPed)
    TriggerServerEvent('pawal:craftkitreparation', nombreCraft)
end

function startcraftnettoyage(nombreCraft)
    local playerPed = GetPlayerPed(-1)
    if Config.progressbar == true then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        Config.customprogressbar(2000*nombreCraft, "Craft en cours...")
    end

    if Config.progressbar == false then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        ESX.ShowNotification('~g~Craft en cours ...')
        Wait(2000*nombreCraft)
    end
    ClearPedTasks(playerPed)
    TriggerServerEvent('pawal:craftkitnettoyage', nombreCraft)
end

RegisterNetEvent('pawal:startcraftnettoyage')
AddEventHandler('pawal:startcraftnettoyage', function(nombreCraft)
    local playerPed = GetPlayerPed(-1)
    if Config.progressbar == true then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        Config.customprogressbar(2000*nombreCraft, "Craft en cours...")
    end

    if Config.progressbar == false then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        ESX.ShowNotification('~g~Craft en cours ...')
        Wait(2000*nombreCraft)
    end
    ClearPedTasks(playerPed)
    TriggerServerEvent('pawal:craftkitnettoyage', nombreCraft)
end)

RegisterNetEvent('pawal:startcraftreparation')
AddEventHandler('pawal:startcraftreparation', function(nombreCraft)
    local playerPed = GetPlayerPed(-1)
    if Config.progressbar == true then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        Config.customprogressbar(2000*nombreCraft, "Craft en cours...")
    end

    if Config.progressbar == false then
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
        ESX.ShowNotification('~g~Craft en cours ...')
        Wait(2000*nombreCraft)
    end
    ClearPedTasks(playerPed)
    TriggerServerEvent('pawal:craftkitreparationpaid', nombreCraft)
end)