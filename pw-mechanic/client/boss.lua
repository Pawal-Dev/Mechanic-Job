--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                           
local mainMenu = RageUI.CreateMenu("PATRON", "Action") 
local employeeMenu = RageUI.CreateSubMenu(mainMenu, "Patron", "Action")
local gradeMenu = RageUI.CreateSubMenu(mainMenu, "Patron", "Action")
local modificationMenu = RageUI.CreateSubMenu(mainMenu, "Patron", "Action")
local modificationjoueurMenu = RageUI.CreateSubMenu(employeeMenu, "Patron", "Action")
local promouvoirJoueurMenu = RageUI.CreateSubMenu(modificationjoueurMenu, "Patron", "Action")
local open = false

local argentaction = {"~g~Déposer~s~", "~r~Retirer~s~"}
local argentactionindex = 1
local nameplayerselected = "~r~Non défini~s~"
local gradeplayerselected = "~r~Non défini~s~"
local joueuraction = {"~g~Recruter~s~", "~r~Viré~s~"}
local joueuractionindex = 1

Society = {
   money = 0,
}

local graderecuperation = {}
local UserTable = {}
local gradeselectionnermodif = "~r~Non défini~s~"
local gradesalaire = "~r~Non défini~s~"

local job = Config.jobname

mainMenu.X = 0 
mainMenu.Y = 0

mainMenu.Closed = function() 
    open = false 
end 


function bossmechanic()
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
                local joueur, distance = ESX.Game.GetClosestPlayer()

                RageUI.Separator('Entreprise : ~o~'..ESX.PlayerData.job.label)
                RageUI.Separator('Fond Disponible : ~g~'..Society.money.." "..Config.Devise)

                RageUI.line(255,255,255,255)

                RageUI.List("Action Argent : ", argentaction, argentactionindex, nil, {}, true, {
                    onListChange = function(i, Items)
                        if argentactionindex ~= i then
                            argentactionindex = i;
                        end
                    end,
                    onSelected = function()
                        if argentactionindex == 1 then
                            local depot = KeyboardInput('La somme à déposé ?' , '', 2000)
                            if depot ~= nil and depot ~= "" then
                                depot = tonumber(depot)
                                if type(depot) == "number" then 
                                    TriggerServerEvent("pawal:ActionMoneyMechanic", "society_"..Config.jobname, Society.money, depot, 1)
                                    Wait(100)
                                    ESX.TriggerServerCallback('pawal:getmoneymechanic', function(money)
                                        Society.money = money
                                    end)
                                end
                            end
                         end

                         if argentactionindex == 2 then
                            local retrait = KeyboardInput('La somme à retiré ?' , '', 2000)
                            if retrait ~= nil and retrait ~= "" then
                                retrait = tonumber(retrait)
                                if type(retrait) == "number" then 
                                    TriggerServerEvent("pawal:ActionMoneyMechanic", "society_"..Config.jobname, Society.money, retrait, 2)
                                    Wait(100)
                                    ESX.TriggerServerCallback('pawal:getmoneymechanic', function(money)
                                        Society.money = money
                                    end)
                                end
                            end
                        end
                    end
                })    

                RageUI.List("Action Joueur : ", joueuraction, joueuractionindex, nil, {}, true, {
                    onListChange = function(i, Items)
                        if joueuractionindex ~= i then
                            joueuractionindex = i;
                        end
                    end,
                    onActive = function()
                        MarkerOnPlayer()
                    end,
                    onSelected = function()
                    if joueuractionindex == 1 then
                        if joueur ~= -1 and distance <= 3.5 then
                            TriggerServerEvent("pawal:recruterjoueurlspd", GetPlayerServerId(joueur))
                        else
                            ESX.ShowNotification('~r~Aucun joueur à proximité')
                        end
                    end

                    if joueuractionindex == 2 then
                        if joueur ~= -1 and distance <= 3.5 then
                            TriggerServerEvent("pawal:virerjoueurmechanic", GetPlayerServerId(joueur))
                        else
                            ESX.ShowNotification('~r~Aucun joueur à proximité')
                        end
                     end
                 end
                }) 

                RageUI.Button("Gestion Employée", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        table.sort(graderecuperation, function(a, b)
                            return a.gradeJob > b.gradeJob
                        end)
                        Wait(200)
                    end
                }, employeeMenu)     

                RageUI.Button("Gestion Grade", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                    end
                }, gradeMenu)   
              end)

              RageUI.IsVisible(employeeMenu, function()
                RageUI.Separator('Membre : ~g~'..#UserTable)
                RageUI.line(255,255,255,255)

                for k,v in pairs(UserTable) do

                    for k,x in pairs(graderecuperation) do
                        if v.job == Config.jobname and v.grade == x.gradeJob then
                          gradeplayer = x.gradeLabel
                        end
                    end

                    RageUI.Button('[~b~'..gradeplayer..'~s~] '..v.firstname..' '..v.lastname, nil, {RightLabel = "→→"}, true, {
                        onSelected = function()  
                            for k,x in pairs(graderecuperation) do
                                if v.job == Config.jobname and v.grade == x.gradeJob then
                                  gradeplayerselected = x.gradeLabel
                                  identifierplayerselectedd = v.identifier
                                end
                            end
                            nameplayerselected = v.firstname..' '..v.lastname
                        end
                    }, modificationjoueurMenu) 
               end
              end)

              RageUI.IsVisible(gradeMenu, function()
                RageUI.Separator('Nombre de grade : ~g~'..#graderecuperation)

                for k,v in pairs(graderecuperation) do
                    RageUI.Button("[~b~"..tonumber(v.gradeJob).."~s~] "..v.gradeLabel, nil,{RightLabel = ""}, true, {
                        onSelected = function()
                            gradeselectionnermodif = v.gradeLabel
                            gradenombre = tonumber(v.gradeJob)
                            gradesalaire = v.gradeSalaire
                            Wait(100)
                        end
                    }, modificationMenu)
                end
              end)

              RageUI.IsVisible(modificationMenu, function()
                RageUI.Separator('Label : ~g~'..gradeselectionnermodif)
                RageUI.Separator('Salaire : ~g~'..gradesalaire.." "..Config.Devise)
                RageUI.line(255,255,255,255)
                RageUI.Button("Modifier le salaire", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local modifsalary = KeyboardInput('Veuillez définir le nouveau salaire' , '', 2000)
                        if modifsalary ~= nil and modifsalary ~= "" then
                            TriggerServerEvent('pawal:editgrademechanic', modifsalary, Config.jobname, gradenombre)
                            gradesalaire = modifsalary
                            Wait(100)
                            ESX.TriggerServerCallback('pawal:getgrademechanic', function(grade)
                                graderecuperation = grade
                            end)
                            Wait(100)
                            table.sort(graderecuperation, function(a, b)
                                return a.gradeJob > b.gradeJob
                            end)
                            Wait(300)
                            ESX.ShowNotification('~g~Changement effectué (Changement sera présent au prochain reboot)')
                        end
                    end
                }) 
              end)

              RageUI.IsVisible(modificationjoueurMenu, function()
                RageUI.Separator('Membre : ~g~'..nameplayerselected)
                RageUI.Separator('Grade : ~o~'..gradeplayerselected)
                RageUI.line(255,255,255,255)

                    RageUI.Button('Promouvoir / Rétrograder', nil, {RightLabel = "→→"}, true, {
                        onSelected = function()  
                            table.sort(graderecuperation, function(a, b)
                                return a.gradeJob > b.gradeJob
                            end)
                            Wait(200)
                        end
                    }, promouvoirJoueurMenu) 

                    
                    RageUI.Button('~r~Virer l\'individu', nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, {
                        onSelected = function()  
                            TriggerServerEvent("pawal:vireplayerlspd", identifierplayerselectedd, nameplayerselected)
                            Wait(100)
                            ESX.TriggerServerCallback('pawal:recuperationplayerlist', function(player)
                                UserTable = player
                            end, job)
                            Wait(200)
                            table.sort(UserTable, function(a, b)
                                return a.grade > b.grade
                            end)
                            RageUI.GoBack()
                        end
                    }) 
              end)

              RageUI.IsVisible(promouvoirJoueurMenu, function()    
                    
                RageUI.Separator('Membre : ~g~'..nameplayerselected)
                RageUI.Separator('Grade Actuel : ~o~'..gradeplayerselected)
                RageUI.line(255,255,255,255)

                for k,v in pairs(graderecuperation) do
                    RageUI.Button("[~b~"..tonumber(v.gradeJob).."~s~] "..v.gradeLabel, nil,{RightLabel = ""}, true, {
                        onSelected = function()
                            TriggerServerEvent('pawal:promouvoirplayer', identifierplayerselectedd, job, v.gradeJob, v.gradeLabel, nameplayerselected)
                            Wait(200)
                            ESX.TriggerServerCallback('pawal:recuperationplayerlist', function(player)
                                UserTable = player
                            end, job)
                            Wait(200)
                            table.sort(UserTable, function(a, b)
                                return a.grade > b.grade
                            end)
                            RageUI.Visible(menu_gestionjoueur, true)
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
       if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname and ESX.PlayerData.job.grade_name == "boss" then
          local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
          local pos = Config.Boss.position
          local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
          if dist3 <= Config.drawdistance then
            playerPed = PlayerPedId()
            if Config.Boss.usemarker == true then
                DrawMarker(Config.MarkerType, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end
              Timer = 0
              if dist3 <= 1.0 and open == false and Config.Boss.usetarget == false then 
                  Timer = 0
                  ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accédez à la gestion patron")
                      if IsControlJustPressed(1,51) then  
                        if Config.Boss.usecustomboss == false then
                            ESX.TriggerServerCallback('pawal:getgrademechanic', function(grade)
                                graderecuperation = grade
                            end, job)
                            Wait(100)
                            table.sort(graderecuperation, function(a, b)
                                return a.gradeJob > b.gradeJob
                            end)
                            ESX.TriggerServerCallback('pawal:getgrademechanic', function(grade)
                                graderecuperation = grade
                            end)
                            ESX.TriggerServerCallback('pawal:getplayermechanicjob', function(player)
                                UserTable = player
                            end)
                            ESX.TriggerServerCallback('pawal:getmoneymechanic', function(money)
                                Society.money = money
                            end)
                            Wait(50)
                            bossmechanic()
                        else
                            Config.Boss.opencustomboss()
                        end     
                      end 
                  end
              end
           end 
       Citizen.Wait(Timer)
   end
end)

function opengestionmenu()
    ESX.TriggerServerCallback('pawal:getgrademechanic', function(grade)
        graderecuperation = grade
    end, job)
    Wait(100)
    table.sort(graderecuperation, function(a, b)
        return a.gradeJob > b.gradeJob
    end)
    ESX.TriggerServerCallback('pawal:getgrademechanic', function(grade)
        graderecuperation = grade
    end)
    ESX.TriggerServerCallback('pawal:getplayermechanicjob', function(player)
        UserTable = player
    end)
    ESX.TriggerServerCallback('pawal:getmoneymechanic', function(money)
        Society.money = money
    end)
    Wait(50)
    bossmechanic()  
end