--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                           
local mainMenu = RageUI.CreateMenu("COFFRE", "Action") 
local depotitem = RageUI.CreateSubMenu(mainMenu, "Dépôt", "Action")
local retraititem = RageUI.CreateSubMenu(mainMenu, "Retrait", "Action")
local open = false
local all_items = {}
local societyitem = {}
local recherche = nil
local rechercheactivation = false

mainMenu.X = 0 
mainMenu.Y = 0

mainMenu.Closed = function() 
    open = false 
end 


function coffremechanic()
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

			
                    RageUI.Button("Déposer un/des objet(s)", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            getInventory()
                        end
                        }, depotitem)	
        
                        RageUI.Button("Retirer un/des objet(s)", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                getStock()
                            end
                        }, retraititem)	
                    end)
        
                    RageUI.IsVisible(depotitem, function()
                     if #all_items == 0 then
                        RageUI.Separator('')
                        RageUI.Separator('~r~Vous n\'avez rien sur vous')
                        RageUI.Separator('')
                     else
                        for k,v in pairs(all_items) do
                            RageUI.Button(v.label, nil, {RightLabel = "~g~x"..math.round(v.nb)}, true, {onSelected = function()
                                local count = KeyboardInput("~s~Quantité à déposer ?", '' , '', 80)
                                count = tonumber(count)
                                TriggerServerEvent("pawal:depotbenny",v.item, count, ESX.PlayerData.job.grade_label)
                                getInventory()
                            end});
                        end
                     end
                   end)
        
                   RageUI.IsVisible(retraititem, function()
                    if #societyitem == 0 then
                        RageUI.Separator('')
                        RageUI.Separator('~r~Coffre Vide')
                        RageUI.Separator('')
                    else
                    RageUI.Button("Rechercher un item", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            local itemrecherche = KeyboardInput("~s~Item rechercher ?", '' , '', 80)
                                        if itemrecherche ~= "" and itemrecherche ~= nil then
                                        recherche = itemrecherche
                                        rechercheactivation = true
                                        else
                                            ESX.ShowNotification('~r~Rercherche invalide !')
                                 end
                        end
                    })
        
                    if rechercheactivation == true then
                        RageUI.Button("Supprimer la recherche", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                              recherche = nil
                              rechercheactivation = false
                            end
                        })
                        RageUI.Separator('Item rechercher : ~g~'..recherche)
                    end
        
                    RageUI.line(255,255,255,255)
        
                    for k,v in pairs(societyitem) do
                        if recherche ~= nil then
                            if starts(v.label:lower(), recherche:lower()) then
                                RageUI.Button(v.label, nil, {RightLabel = "~g~x"..math.round(v.nb)}, true, {onSelected = function()
                                    local count = KeyboardInput("~s~Quantité à retirer ?", '' , '', 80)
                                    count = tonumber(count)
                                    if count <= v.nb then
                                        TriggerServerEvent("pawal:retraitbenny", v.item, count, ESX.PlayerData.job.grade_label)
                                    else
                                        ESX.ShowNotification("~r~Pas assez de stock de "..v.label.." pour pouvoir retirer le montant saisi")
                                    end
                                    getStock()
                                end});
                           end
                       end
                       if recherche == nil then
                        RageUI.Button(v.label, nil, {RightLabel = "~g~x"..math.round(v.nb)}, true, {onSelected = function()
                            local count = KeyboardInput("~s~Quantité à retirer ?", '' , '', 80)
                            count = tonumber(count)
                            if count <= v.nb then
                                TriggerServerEvent("pawal:retraitbenny", v.item, count, ESX.PlayerData.job.grade_label)
                            else
                                ESX.ShowNotification("~r~Pas assez de stock de "..v.label.." pour pouvoir retirer le montant saisi")
                            end
                            getStock()
                        end});
                     end
                    end
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
          local pos = Config.Coffre.position
          local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
          if dist3 <= Config.drawdistance then
              Timer = 0
              if Config.Coffre.usemarker == true then
                DrawMarker(Config.MarkerType, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
              end
                if dist3 <= 1.0 and open == false and Config.Coffre.usetarget == false then 
                  Timer = 0
                  ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accedez au coffre")
                      if IsControlJustPressed(1,51) then  
                        if service == true then 
                            if Config.Coffre.usecustomcoffre == false then
                                coffremechanic()     
                            else    
                                Config.Coffre.customopencoffre()
                            end
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

