if Config.framework == "newesx" then
    ESX = exports["es_extended"]:getSharedObject()
else
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(10)
        end
        while ESX.GetPlayerData().job == nil do
              Citizen.Wait(10)
        end
        if ESX.IsPlayerLoaded() then
  
            ESX.PlayerData = ESX.GetPlayerData()
  
         end
      end)
end


service = false
if Config.usesystemservice == false then
    service = true
end
local PlayerData = {}

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
	end
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

function GetCloseVehi()
    local player = GetPlayerPed(-1)
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()),3.0, 0, 70)
    local vCoords = GetEntityCoords(vehicle)
    DrawMarker(2, vCoords.x, vCoords.y, vCoords.z + 1.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 125, 255, 85, 1, 1, 2, 1, nil, nil, 0)
end

function MarkerOnPlayer()
	local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
	local pos = GetEntityCoords(ped)
	local target, distance = ESX.Game.GetClosestPlayer()
  if distance <= 3.0 and target ~= -1 then
	DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 170, 0, 1, 2, 1, nil, nil, 0)
  end
end

RegisterNetEvent('pawal:setBlip')
AddEventHandler('pawal:setBlip', function(coords)
    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
    ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Demande d\'Assistance', 'Un Agent du ~y~Benny\'s~s~ demande une ~y~assistance supplémentaire~s~.\n[~y~Voir GPS~s~]', 'CHAR_CARSITE3', 1)
    Wait(1000)
    PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('[~y~Benny\'s~s~] Demande Assistance')
    EndTextCommandSetBlipName(blipId)
    Wait(80 * 1000)
    RemoveBlip(blipId)
end)

function SpawnCarUnicorn(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(200) 
    end
    local vehicle = CreateVehicle(car, Config.PostionUnicornSpawnVehicle, true, false)
    SetEntityAsNoLongerNeeded(vehicle)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetVehicleNumberPlateText(vehicle, "UNICORN")
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(camera, 168.43, -1278.54, 29.29)
	RenderScriptCams(1, 1, 1000, 1, 1)
    PointCamAtEntity(camera, vehicle)
end 

if Config.Garage.usepreview == true then                               
    PreviewCache = {}
    CreatePreview = function(vehHash)
        local CarDealer = Config.Garage.spawncar
        RequestModel(vehHash)
        while not HasModelLoaded(vehHash) do Wait(1) end
        local previewcar = CreateVehicle(vehHash, CarDealer.x, CarDealer.y, CarDealer.z, 0, false, true)
        SetVehicleOnGroundProperly(previewcar)
        FreezeEntityPosition(previewcar, 1)
        PreviewCache.entity = previewcar
        PreviewCache.model = vehHash
        SetModelAsNoLongerNeeded(vehHash)
        SetVehicleEngineOn(PreviewCache.entity, true, true, true)
        SetVehRadioStation(PreviewCache.entity, 'OFF')
        SetVehicleNumberPlateText(PreviewCache.entity, '')
        Wait(0)
        SetEntityHeading(PreviewCache.entity, Config.Garage.spawnheading)

        if Config.Garage.usecustomcamera == true then
            camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
            SetCamCoord(camera, Config.Garage.poscamera.x, Config.Garage.poscamera.y, Config.Garage.poscamera.z + 1.0)
            PointCamAtEntity(camera, previewcar, 0, 0, 0, 1)
            SetCamNearDof(camera, 10)
            RenderScriptCams(1, 1, 2000, 1, 1)
            SetCamShakeAmplitude(camera, 130.0)
            camGo = false
        end
    end
end

function getInventory()
    ESX.TriggerServerCallback('pawal:bennyinventairejoueur', function(inventory)               
                
        all_items = inventory

    end)
end

function getStock()
    ESX.TriggerServerCallback('pawal:récupérationstockitemsociety', function(item)               
                
        societyitem = item
        
    end)
end

function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function setskintoplayer(infos)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = infos.variations.male
		else
			uniformObject = infos.variations.female
		end
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end

		infos.onEquip()
	end)
end

function setWaypoint(type)
    if DoesBlipExist(pointfarm) then
        RemoveBlip(pointfarm)
    end
    if type == "feraille" then
        pointfarm = AddBlipForCoord(Config.Farm.positionferraille.x, Config.Farm.positionferraille.y, Config.Farm.positionferraille.z)
        SetBlipDisplay(pointfarm, 4)
        SetBlipScale(pointfarm, 1.0)
        SetBlipColour(pointfarm, 1)
        SetBlipAsShortRange(pointfarm, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Farm Feraille")
        EndTextCommandSetBlipName(pointfarm)
        SetBlipRoute(pointfarm, true)

        while DoesBlipExist(pointfarm) do
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.Farm.positionferraille
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
            if dist3 <= 12.0 then
                RemoveBlip(pointfarm)
            end
            Wait(100)
        end
    elseif type == "acier" then
        pointfarm = AddBlipForCoord(Config.Farm.positionacier.x, Config.Farm.positionacier.y, Config.Farm.positionacier.z)
        SetBlipDisplay(pointfarm, 4)
        SetBlipScale(pointfarm, 1.0)
        SetBlipColour(pointfarm, 1)
        SetBlipAsShortRange(pointfarm, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Farm Acier")
        EndTextCommandSetBlipName(pointfarm)
        SetBlipRoute(pointfarm, true)

        while DoesBlipExist(pointfarm) do
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.Farm.positionacier
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
            if dist3 <= 12.0 then
                RemoveBlip(pointfarm)
            end
            Wait(100)
        end
    elseif type == "none" then
        if DoesBlipExist(pointfarm) then
            RemoveBlip(pointfarm)
        end
    end
end

NPCOnJob = false
CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
function StartNPCJob()
	NPCOnJob = true
    TriggerServerEvent('pawal:missionlogs', "Début de mission" ,ESX.PlayerData.job.grade_label)
	NPCTargetTowableZone = SelectRandomTowable()
	local zone       = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

    ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification',"Rendez-vous à la ~y~position GPS~s~ afin de ~y~dépanner le véhicule~s~", 'CHAR_CARSITE3', 1)
end

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob                = false
	NPCTargetTowable        = nil
	NPCTargetTowableZone    = nil
	NPCHasSpawnedTowable    = false
	NPCHasBeenNextToTowable = false

	if cancel then
        TriggerServerEvent('pawal:missionlogs', "Fin de mission (Abandon)" ,ESX.PlayerData.job.grade_label)
        ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification',"~r~Vous venez de stopper la mission !", 'CHAR_CARSITE3', 1)
	end
end

AddEventHandler('pawal:markeractivation', function(zone, station, part, partNum)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
    end
end)

AddEventHandler('pawal:markerdesactivation', function(zone, station, part, partNum)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
    end
	CurrentAction = nil
end)


                

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('pawal:markeractivation', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('pawal:markerdesactivation', LastZone)
			end

		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
                    SetVehicleEngineHealth(vehicle, 300)
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
                ESX.ShowAdvancedNotification('Benny\'s Motor Works', '~y~Notification',"Veuillez ~y~remorquer~s~ le véhicule", 'CHAR_CARSITE3', 1)
				NPCHasBeenNextToTowable = true
			end
		end
	end
end)

if Config.userepairkit then 

    RegisterNetEvent('pawal:utilisationkitreparation')
    AddEventHandler('pawal:utilisationkitreparation', function()
                local playerPed = PlayerPedId()
                local coords    = GetEntityCoords(playerPed)
            
                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
                    local vehicle
            
                    if IsPedInAnyVehicle(playerPed, false) then
                        vehicle = GetVehiclePedIsIn(playerPed, false)
                    else
                        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                    end
            
                    if DoesEntityExist(vehicle) then
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        if Config.progressbar == true then
                            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            Config.customprogressbar(10000, "Utilisation du kit de réparation  ...")
                        end
            
                        if Config.progressbar == false and usetarget == true then
                            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            ESX.ShowNotification('~g~Utilisation du kit de réparation ...')
                            Wait(10000)
                        end
                        SetVehicleFixed(vehicle)
                        SetVehicleDeformationFixed(vehicle)
                        SetVehicleUndriveable(vehicle, false)
                        ClearPedTasksImmediately(playerPed)
            end
        end
    end)
end
   
if Config.usecleankit then
    RegisterNetEvent('pawal:utilisationkitnettoyage')
    AddEventHandler('pawal:utilisationkitnettoyage', function()
                local playerPed = PlayerPedId()
                local coords    = GetEntityCoords(playerPed)
            
                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
                    local vehicle
            
                    if IsPedInAnyVehicle(playerPed, false) then
                        vehicle = GetVehiclePedIsIn(playerPed, false)
                    else
                        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                    end
            
                    if DoesEntityExist(vehicle) then
                        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                        if Config.progressbar == true then
                            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                            Config.customprogressbar(10000, "Utilisation du kit de nettoyage  ...")
                        end
            
                        if Config.progressbar == false and usetarget == true then
                            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                            ESX.ShowNotification('~g~Utilisation du kit de nettoyage ...')
                            Wait(10000)
                        end
                        SetVehicleDirtLevel(vehicle, 0.0)
                        SetVehicleUndriveable(vehicle, false)
                        ClearPedTasksImmediately(playerPed)
            end
        end
    end)
end