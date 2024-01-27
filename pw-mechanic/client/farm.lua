--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
if not Config.Etabli.payforcraftreparationkit then
    if Config.userepairkit then
        farmencoursferaille = false
        Citizen.CreateThread(function()
        while true do
            local Timer = 800
            if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname then
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Farm.positionferraille
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
                if dist3 <= Config.drawdistance then
                    if Config.Farm.usemarker == true then
                        DrawMarker(Config.MarkerType, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                    end
                    Timer = 0
                    if dist3 <= 1.8 then 
                        Timer = 0
                        playerPed = PlayerPedId()
                        if farmencoursferaille == false and Config.Farm.usetarget == false then
                            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour récolter la ferraille")
                        elseif farmencoursferaille == true and Config.Farm.usetarget == false then
                            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour stopper la récolte")
                        end
                            if IsControlJustPressed(1,51) then   
                            if service == true then
                                recolteferraille()
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

        farmencoursacier = false
        Citizen.CreateThread(function()
        while true do
            local Timer = 800
            if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname then
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Farm.positionacier
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
                if dist3 <= Config.drawdistance then
                    if Config.Farm.usemarker == true then
                        DrawMarker(Config.MarkerType, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                    end
                    Timer = 0
                    if dist3 <= 1.8 then 
                        Timer = 0
                        playerPed = PlayerPedId()
                        if farmencoursacier == false and Config.Farm.usetarget == false then
                            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour récolter l\'acier")
                        elseif farmencoursacier == true and Config.Farm.usetarget == false then
                            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour stopper la récolte")
                        end
                            if IsControlJustPressed(1,51) then   
                            if service == true then
                                recolteacier()
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
    end
end
