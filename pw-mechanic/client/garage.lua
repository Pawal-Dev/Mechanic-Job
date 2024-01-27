--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                           
 local mainMenu = RageUI.CreateMenu("GARAGE", "Action") 
 local open = false
 
 mainMenu.X = 0 
 mainMenu.Y = 0
 
 mainMenu.Closed = function() 
     open = false 
     if Config.Garage.usepreview == true then                              
        FreezeEntityPosition(PlayerPedId(), false)
        if DoesEntityExist(PreviewCache.entity) then
            DeleteVehicle(PreviewCache.entity)
            PreviewCache = {}
            PreviewCache.model = nil
        end
    end
    if Config.Garage.usecustomcamera == true then
        RenderScriptCams(0, 1, 750, 1, 1)
        DestroyCam(camera, true)
        camGo = true
        veh = nil
    end
 end 


 function garagemechanic()
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
                 RageUI.IsVisible(mainMenu, function()            
                    for k, v in pairs(Config.Garage.ListeVehicle) do
                        RageUI.Button("Faire spawn  : "..v.label, nil, {RightLabel = ""}, true, {
                        onActive = function()  
                            if Config.Garage.usepreview == true then                              
                                if PreviewCache.model ~= v.model then
                                    DeleteVehicle(PreviewCache.entity)
                                    CreatePreview(v.model)
                                end
                            end
                        end,
                        onSelected = function()
                            if Config.Garage.usepreview == true then                              
                                if DoesEntityExist(PreviewCache.entity) then
                                    DeleteVehicle(PreviewCache.entity)
                                    PreviewCache = {}
                                    PreviewCache.model = nil
                                end
                            end
                            if not ESX.Game.IsSpawnPointClear(vector3(Config.Garage.spawncar.x, Config.Garage.spawncar.y, Config.Garage.spawncar.z), 10.0) then
                                ESX.ShowNotification("~r~Point de spawn des véhicules trop encombrer !")
                            else
                                local model = GetHashKey(v.model)
                                RequestModel(model)
                                while not HasModelLoaded(model) do Wait(10) end
                                if Config.Garage.usecustomcamera == true then
                                    RenderScriptCams(0, 1, 750, 1, 1)
                                    DestroyCam(camera, true)
                                    camGo = true
                                    veh = nil
                                end
                                local vehiclebenny = CreateVehicle(model, Config.Garage.spawncar.x, Config.Garage.spawncar.y, Config.Garage.spawncar.z, Config.Garage.spawnheading, true, false)
                                SetVehicleFixed(vehiclebenny)
                                SetVehicleDirtLevel(vehiclebenny, 0.0)
                                SetVehicleFuelLevel(vehiclebenny, 100.0)
                                SetVehRadioStation(vehiclebenny, 0)
                                if Config.Garage.usekeysystem == true then
                                    Config.Garage.keygivefonction(GetVehicleNumberPlateText(vehiclebenny))
                                end
                                ESX.ShowNotification('Vous venez de sortir un/une ~g~ '..GetLabelText(v.model))
                                TriggerServerEvent('pawal:logs', "Sortie d'un véhicule" ,ESX.PlayerData.job.grade_label, GetLabelText(v.model))
                                FreezeEntityPosition(PlayerPedId(), false)
                                RageUI.CloseAll()
                                open = false
                            end
                        end
                        })	
                    end
               end)
             Wait(0)
             end
         end)
     end
 end


Citizen.CreateThread(function()
    while true do
        local Timer = 800
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname then
           local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
           local pos = Config.Garage.position
           local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
           if dist3 <= Config.drawdistance then
               Timer = 0
               if dist3 <= 1.0 and open == false and Config.Garage.usetarget == false then 
                   Timer = 0
                   ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accedez au garage")
                       if IsControlJustPressed(1,51) then   
                        if service == true then
                            FreezeEntityPosition(PlayerPedId(), true)
                            garagemechanic()       
                        else
                            ESX.ShowNotification('~r~Vous n\'êtes pas en service')
                        end  
                       end 
                   end
               end
            end 
        Citizen.Wait(Timer)
    end
end)

 Citizen.CreateThread(function()
		local hash = GetHashKey(Config.Garage.pedmodel)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped = CreatePed("PED_TYPE_CIVFEMALE", Config.Garage.pedmodel, Config.Garage.pedposition.x, Config.Garage.pedposition.y, Config.Garage.pedposition.z-0.92, Config.Garage.pedposition.h, false, true)
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
 end)  

 
 Citizen.CreateThread(function()
    while true do
        local Timer = 800
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.Garage.rangerposition.x, Config.Garage.rangerposition.y, Config.Garage.rangerposition.z)
        if dist3 <= Config.drawdistance then
            Timer = 0
           if IsPedSittingInAnyVehicle(PlayerPedId()) then
            DrawMarker(Config.MarkerType, Config.Garage.rangerposition.x, Config.Garage.rangerposition.y, Config.Garage.rangerposition.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, Config.MarkerTourne, Config.MarkerTourne)  
        if dist3 <= 3.0 then 
                Timer = 0
                ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour ranger votre ~b~véhicule")
                        if IsControlJustPressed(1,51) then
                            if service == true then
                            local veh, dist4 = ESX.Game.GetClosestVehicle()
                            if dist4 < 4 then
                                local model = GetEntityModel(veh)
                                local displaytext = GetDisplayNameFromVehicleModel(model)
                                for k, v in pairs(Config.Garage.ListeVehicle) do   
                                    if displaytext == v.model:upper() then
                                    vehiclemodel = v.model:upper()
                                    namevehicle = v.label
                                    end
                                end  
                                if IsPedSittingInAnyVehicle(PlayerPedId()) and displaytext == vehiclemodel then
                                TaskLeaveVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)	
                                Citizen.Wait(2000)
                                if Config.Garage.usekeysystem == true then
                                    Config.Garage.keyremovefonction(GetVehicleNumberPlateText(veh))
                                end
                                ESX.ShowNotification('~g~Vous venez de ranger votre '..namevehicle)
                                DeleteEntity(veh)
                            else
                                ESX.ShowNotification('~r~Vous ne pouvez pas ranger ce modèle de véhicule dans ce garage')
                            end
                        else
                            ESX.ShowNotification('~r~Vous n\'êtes pas en service')
                        end
                        end
                    end 
                end  
                end
            end
            end 
        Citizen.Wait(Timer)
    end
end)