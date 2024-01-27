--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                           
local mainMenu = RageUI.CreateMenu("VESTIAIRE", "Action") 
local open = false

mainMenu.X = 0 
mainMenu.Y = 0

mainMenu.Closed = function() 
    open = false 
end 


function vestiairemechanic()
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
              while not HasAnimDictLoaded("clothingtie") do RequestAnimDict("clothingtie") Wait(100) end         
              RageUI.IsVisible(mainMenu, function()  
                RageUI.Button("Reprendre sa tenue de civil", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_positive_a", 3.0, 3.0, 3200, 0, 0, false, false, false)
                        if Config.progressbar == true then
                           Config.customprogressbar(3200, "Changement de tenue...")
                        else
                           Wait(3200)
                        end
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin) 
                        TriggerEvent('skinchanger:loadSkin', skin) 
                      end)
                      if service == true and Config.usesystemservice == true then
                        TriggerServerEvent('pawal:finservice', ESX.PlayerData.job.grade_label)
                        service = false
                        setTargetState(false)
                     end
                    end
                    })	
                RageUI.line(255,255,255,255)   
                for _,infos in pairs(Config.Vestiaire.MecanoOutfit.clothes) do
                    RageUI.Button(infos.label, nil, {RightLabel = "→→"}, ESX.PlayerData.job.grade >= infos.minimum_grade, {
                    onSelected = function()
                         TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_positive_a", 3.0, 3.0, 3200, 0, 0, false, false, false)
                         if Config.progressbar == true then
                            Config.customprogressbar(3200, "Changement de tenue...")
                         else
                            Wait(3200)
                         end
                         setskintoplayer(infos)

                         if service == false then
                            TriggerServerEvent('pawal:priseservice', ESX.PlayerData.job.grade_label)
                            service = true
                            setTargetState(true)
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
          local pos = Config.Vestiaire.position
          local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
          if dist3 <= Config.drawdistance then
            playerPed = PlayerPedId()
            if Config.Vestiaire.usemarker == true then
                DrawMarker(Config.MarkerType, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end
              Timer = 0
              if dist3 <= 1.0 and open == false and Config.Vestiaire.usetarget == false then 
                  Timer = 0
                  ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accédez au vestiaire")
                      if IsControlJustPressed(1,51) then  
                         vestiairemechanic()     
                      end 
                  end
              end
           end 
       Citizen.Wait(Timer)
   end
end)

