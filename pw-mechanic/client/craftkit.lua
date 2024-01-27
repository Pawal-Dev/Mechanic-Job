--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
 

local mainMenu = RageUI.CreateMenu("ETABLI", "Action") 
local open = false
local nbSouhaiter = 1
local checkisvalid = "~r~Non défini~s~"
local checkisvalid2 = "~r~Non défini~s~"
local validationferraille = false
local validationacier = false
local breakloop = false
local validation = "~r~Non défini~s~"
local checkresult = {}

mainMenu.X = 0 
mainMenu.Y = 0

mainMenu.Closed = function() 
    RageUI.CloseAll()
    open = false
end 

if Config.userepairkit or Config.usecleankit then
    function etablimechanic()
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

                        RageUI.Separator('Nombre de kit souhaiter : ~g~'.. nbSouhaiter)

                        RageUI.Button("Saisir un nombre de kit", nil, {RightLabel = "→→→"}, true, {
                            onActive = function()
                                breakloop = false
                                active = false
                            end,
                            onSelected = function()
                                local nbSouhaiterValidation = KeyboardInput("Veuillez saisir le nombre de kit souhaiter", "", 100)
                                nbSouhaiterValidation = tonumber(nbSouhaiterValidation)
                                if nbSouhaiterValidation ~= nil and nbSouhaiterValidation ~= "" and nbSouhaiterValidation >= 1 then
                                    nbSouhaiter = nbSouhaiterValidation
                                    breakloop = false
                                else
                                    ESX.ShowNotification('~r~Merci de saisir une valeur possible')
                                end
                            end
                        })	

                        RageUI.line(255,255,255,255)

                    if Config.Etabli.payforcraftreparationkit == false then

                        if Config.userepairkit then
                            RageUI.Button("Fabriquer un kit de réparation", nil, {RightLabel = "→→"}, true, {
                            onActive = function()
                                if not breakloop then
                                    ESX.TriggerServerCallback('pawal:checkitem', function(nb) 
                                        if nb >= Config.Etabli.ferraillerequis * nbSouhaiter  then
                                            checkisvalid = "~g~Suffisant~s~ (~g~"..tonumber(nb).."/"..tonumber(Config.Etabli.ferraillerequis) * nbSouhaiter.."~s~)"
                                            validationferraille = true
                                        elseif nb < Config.Etabli.ferraillerequis * nbSouhaiter then 
                                            checkisvalid = "~r~Insuffisant~s~ (~r~"..tonumber(nb).."/"..tonumber(Config.Etabli.ferraillerequis) * nbSouhaiter.."~s~)"
                                            validationferraille = false
                                        end
                                    end, "ferraille")

                                    ESX.TriggerServerCallback('pawal:checkitem', function(nb) 
                                        if nb >= Config.Etabli.acierrequis * nbSouhaiter then
                                            checkisvalid2 = "~g~Suffisant~s~ (~g~"..tonumber(nb).."/"..tonumber(Config.Etabli.acierrequis) * nbSouhaiter.."~s~)"
                                            validationacier = true
                                        elseif nb < Config.Etabli.acierrequis * nbSouhaiter then
                                            checkisvalid2 = "~r~Insuffisant~s~ (~r~"..tonumber(nb).."/"..tonumber(Config.Etabli.acierrequis) * nbSouhaiter.."~s~)"
                                            validationacier = false
                                        end
                                    end, "acier")

                                    breakloop = true
                                end
                                active = true
                            end,
                            onSelected = function()
                                if validationacier == true and validationferraille == true then
                                    RageUI.CloseAll()
                                    open = false
                                    startcraft(nbSouhaiter)
                                else
                                    ESX.ShowNotification('~r~Vous n\'avez pas assez de matériaux')
                                end
                            end
                            })	
                    end
                    else
                        RageUI.Button("Fabriquer un kit de réparation", nil, {RightLabel = "~g~"..Config.Etabli.pricekitreparation * nbSouhaiter..""..Config.Devise}, true, {
                            onActive = function()
                                active = false
                                breakloop = false
                            end,
                            onSelected = function()
                                TriggerServerEvent("pawal:verifkitreparation", nbSouhaiter)
                            end
                        })
                    end

                    if Config.usecleankit then
                        RageUI.Button("Fabriquer un kit de nettoyage", nil, {RightLabel = "~g~"..Config.Etabli.pricekitnettoyage * nbSouhaiter..""..Config.Devise}, true, {
                            onActive = function()
                                active = false
                                breakloop = false
                            end,
                            onSelected = function()
                                TriggerServerEvent("pawal:verifkitnettoyage", nbSouhaiter)
                            end
                        })	
                    end

                        if active and Config.Etabli.payforcraftreparationkit == false then
                            if validationacier == true and validationferraille == true then
                                validation = "~g~Possible~s~"
                            else
                                validation = "~r~Impossible~s~"
                            end
                                
                            RageUI.BoutonPanel("Ferraille", checkisvalid, PanelIndex)
                            RageUI.BoutonPanel("Acier", checkisvalid2, PanelIndex)
                            RageUI.BoutonPanel("Fabrication : ", validation, PanelIndex)

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
            local pos = Config.Etabli.position
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
            if dist3 <= Config.drawdistance then
                if Config.Etabli.usemarker == true then
                    DrawMarker(Config.MarkerType, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end
                Timer = 0
                if dist3 <= 1.0 and open == false and Config.Etabli.usetarget == false then 
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accedez à l'établi")
                        if IsControlJustPressed(1,51) then   
                        if service == true then
                            breakloop = false   
                            etablimechanic()    
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