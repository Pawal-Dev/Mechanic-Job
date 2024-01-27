--██████╗ ██╗  ██╗    ████████╗ █████╗ ██████╗  ██████╗ ███████╗████████╗
--██╔═══██╗╚██╗██╔╝    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝
--██║   ██║ ╚███╔╝        ██║   ███████║██████╔╝██║  ███╗█████╗     ██║   
--██║   ██║ ██╔██╗        ██║   ██╔══██║██╔══██╗██║   ██║██╔══╝     ██║   
--╚██████╔╝██╔╝ ██╗       ██║   ██║  ██║██║  ██║╚██████╔╝███████╗   ██║   
-- ╚═════╝ ╚═╝  ╚═╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝
if Config.useoxtarget == true then
	interaction = {}
	function setTargetState(serviceoption)
		if serviceoption == true then

			if Config.userepairtarget then
				table.insert(interaction, {
					name = "repaircar",
					icon = 'fa-solid fa-screwdriver-wrench',
					label = "Réparer le véhicule",	
					groups = Config.jobname,
					canInteract = function(entity, distance, coords, name, boneId)
						return DoesEntityExist(entity)
					end,
					onSelect = function(data)
						repaircar(true)
					end
				})
			end

			if Config.usecleantarget then
				table.insert(interaction, {
					name = "cleancar",
					icon = 'fa-solid fa-soap',
					label = "Nettoyer le véhicule",	
					groups = Config.jobname,
					canInteract = function(entity, distance, coords, name)
						return DoesEntityExist(entity)
					end,
					onSelect = function(data)
						cleancar(true)
					end
				})
			end


			if Config.userefuelltarget then
				table.insert(interaction, {
					name = "refuelcar",
					icon = 'fa-solid fa-gas-pump',
					label = "Remplir le réservoir",	
					groups = Config.jobname,
					canInteract = function(entity, distance, coords, name)
						return DoesEntityExist(entity)
					end,
					onSelect = function(data)
						refuelcar(true)
					end
				})
			end

			if Config.useimpoundtarget then
				table.insert(interaction, {
					name = "impoundcar",
					icon = 'fa-solid fa-fire',
					label = "Mise en fourrière",	
					groups = Config.jobname,
					canInteract = function(entity, distance, coords, name)
						return DoesEntityExist(entity)
					end,
					onSelect = function(data)
						impoundcar(true)
					end
				})
			end

			if Config.useimpoundtarget ~= false or Config.usecleantarget ~= false or Config.userepairtarget ~= false or Config.userefuelltarget ~= false then
				exports.ox_target:addGlobalVehicle(interaction)
			end
		elseif serviceoption == false then
			for k,v in pairs(interaction) do
				exports.ox_target:removeGlobalVehicle(v.name)
			end
			interaction = {}
		end
	end

	if Config.usesystemservice == false then
		setTargetState(true)
	end

	if Config.Garage.usetarget == true then
		exports.ox_target:addBoxZone({
			coords = vec3(Config.Garage.pedposition.x, Config.Garage.pedposition.y, Config.Garage.pedposition.z+1.0),

			size = vec3(2,2,2),
			rotation = 45,
			debug = drawZones,
			options = {
				{
					name = 'garage',
					event = 'pawal:opengarage',
					icon = 'fa-solid fa-warehouse',
					label = 'Sortir un véhicule'
				}
			}
		})
	end

	if Config.Coffre.usetarget == true then
		exports.ox_target:addBoxZone({
			coords = vec3(Config.Coffre.position.x, Config.Coffre.position.y, Config.Coffre.position.z+0.4),

			size = vec3(2,2,2),
			rotation = 45,
			debug = drawZones,
			options = {
				{
					name = 'coffre',
					event = 'pawal:opencoffre',
					icon = 'fa-solid fa-warehouse',
					label = 'Accédez au coffre'
				}
			}
		})
	end

	if Config.Boss.usetarget == true then
		exports.ox_target:addBoxZone({
			coords = vec3(Config.Boss.position.x, Config.Boss.position.y, Config.Boss.position.z+0.4),

			size = vec3(2,2,2),
			rotation = 45,
			debug = drawZones,
			options = {
				{
					name = 'gestionboss',
					event = 'pawal:opengestion',
					icon = 'fa-solid fa-up-right-from-square',
					label = 'Accédez à la gestion'
				}
			}
		})
	end

	if Config.Vestiaire.usetarget == true then
		exports.ox_target:addBoxZone({
			coords = vec3(Config.Vestiaire.position.x, Config.Vestiaire.position.y, Config.Vestiaire.position.z+0.4),

			size = vec3(2,2,2),
			rotation = 45,
			debug = drawZones,
			options = {
				{
					name = 'vestaire',
					event = 'pawal:openvestiaire',
					icon = 'fa-solid fa-shirt',
					label = 'Accédez au vestiaire'
				}
			}
		})
	end

	if Config.userepairkit or Config.usecleankit then
		if Config.Etabli.usetarget == true then
			exports.ox_target:addBoxZone({
				coords = vec3(Config.Etabli.position.x, Config.Etabli.position.y, Config.Etabli.position.z+0.4),

				size = vec3(2,2,2),
				rotation = 45,
				debug = drawZones,
				options = {
					{
						name = 'etabli',
						event = 'pawal:openetabli',
						icon = 'fa-solid fa-gears',
						label = 'Accédez à l\'établi'
					}
				}
			})
		end

		if Config.Farm.usetarget == true and Config.Etabli.payforcraftreparationkit == false then
				exports.ox_target:addBoxZone({
					coords = vec3(Config.Farm.positionferraille.x, Config.Farm.positionferraille.y, Config.Farm.positionferraille.z+0.4),

					size = vec3(5,5,5),
					rotation = 45,
					debug = drawZones,
					options = {
						{
							name = 'ferraille',
							event = 'pawal:recolteferraille',
							icon = 'fa-solid fa-box',
							label = 'Recolter ferraille'
						}
					}
				})

			exports.ox_target:addBoxZone({
				coords = vec3(Config.Farm.positionacier.x, Config.Farm.positionacier.y, Config.Farm.positionacier.z+0.4),

				size = vec3(5,5,5),
				rotation = 45,
				debug = drawZones,
				options = {
					{
						name = 'acier',
						event = 'pawal:recolteacier',
						icon = 'fa-solid fa-box',
						label = 'Recolter l\'acier'
					}
				}
			})
		end
	end
end

RegisterNetEvent('pawal:opengarage')
AddEventHandler('pawal:opengarage', function()
	if service == true then
		FreezeEntityPosition(PlayerPedId(), true)
		garagemechanic()
	else
		ESX.ShowNotification('~r~Vous n\'êtes pas en service')
	end
end)

RegisterNetEvent('pawal:opencoffre')
AddEventHandler('pawal:opencoffre', function()
	if service == true then
		if Config.Coffre.usecustomcoffre == true then
			Config.Coffre.customopencoffre()
		else
			coffremechanic()
		end
	else
		ESX.ShowNotification('~r~Vous n\'êtes pas en service')
	end
end)

RegisterNetEvent('pawal:openvestiaire')
AddEventHandler('pawal:openvestiaire', function()
	if Config.Vestiaire.usecustomvestiaire == true then
		Config.Vestiaire.customvestiaire()
	else
		vestiairemechanic()
	end
end)

RegisterNetEvent('pawal:openetabli')
AddEventHandler('pawal:openetabli', function()
	if service == true then
		if Config.Etabli.usecustomcraft == true then
			Config.Etabli.customcraft()
		else
			etablimechanic()
		end
	else
		ESX.ShowNotification('~r~Vous n\'êtes pas en service')
	end
end)

RegisterNetEvent('pawal:recolteferraille')
AddEventHandler('pawal:recolteferraille', function()
	if service == true then
		recolteferraille()
	else
		ESX.ShowNotification('~r~Vous n\'êtes pas en service')
	end
end)

RegisterNetEvent('pawal:recolteacier')
AddEventHandler('pawal:recolteacier', function()
	if service == true then
		recolteacier()
	else
		ESX.ShowNotification('~r~Vous n\'êtes pas en service')
	end
end)

RegisterNetEvent('pawal:opengestion')
AddEventHandler('pawal:opengestion', function()
	if Config.Boss.usecustomboss == false then
		opengestionmenu()
	else
		Config.Boss.opencustomboss()
	end
end)