Config = {

-- ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗     
--██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║     
--██║  ███╗██║     ██║   ██║██████╔╝███████║██║     
--██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║     
--╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗
-- ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

framework = "newesx", -- esx ou newesx (newesx = nouveau export)        
jobname = "mechanic",
Banniere =  { -- Changer la bannière des différents menu RageUI
    ytdname = "mechanicmenu",
    nameimage = "mechanic_banner"
},
usesystemservice = true, -- Si vous voulez obliger le joueur à être en tenue (service) pour avoir accès au F6 et autre point
Devise = "$",

userepairkit = true, -- Si vous voulez utilisez l'item kit de réparation
usecleankit = true, -- Si vous voulez utilisez l'item kit de nettoyage

--	███╗   ███╗ █████╗ ██████╗ ██╗  ██╗███████╗██████╗     ██████╗  ██████╗ ██╗███╗   ██╗████████╗
--	████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗    ██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
--	██╔████╔██║███████║██████╔╝█████╔╝ █████╗  ██████╔╝    ██████╔╝██║   ██║██║██╔██╗ ██║   ██║   
--	██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗ ██╔══╝  ██╔══██╗    ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║   
--	██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗███████╗██║  ██║    ██║     ╚██████╔╝██║██║ ╚████║   ██║   
--	╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝   
		
drawdistance = 3.0, -- Distance d'affichage des markers
MarkerType = 22, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
MarkerSizeLargeur = 0.2, -- Largeur du marker
MarkerSizeEpaisseur = 0.2, -- Épaisseur du marker
MarkerSizeHauteur = 0.2, -- Hauteur du marker
MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
MarkerColorR = 255, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorG = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorB = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerOpacite = 255, -- Opacité du marker (min: 0, max: 255)
MarkerSaute = false, -- Si le marker saute (true = oui, false = non)
MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)


--   ██████╗ ██╗     ██╗██████╗ 
--   ██╔══██╗██║     ██║██╔══██╗
--   ██████╔╝██║     ██║██████╔╝
--   ██╔══██╗██║     ██║██╔═══╝ 
--   ██████╔╝███████╗██║██║     
--   ╚═════╝ ╚══════╝╚═╝╚═╝     
                           
blipname = "Benny's Motor Work",
blipscale = 0.8, 
blipcolour = 5, 
blipsprite = 446, 
blipdisplay = 4, 
blipposition = vector3(-213.33702087402, -1326.0938720703, 30.906789779663),

--██████╗ ██╗  ██╗    ████████╗ █████╗ ██████╗  ██████╗ ███████╗████████╗
--██╔═══██╗╚██╗██╔╝    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝
--██║   ██║ ╚███╔╝        ██║   ███████║██████╔╝██║  ███╗█████╗     ██║   
--██║   ██║ ██╔██╗        ██║   ██╔══██║██╔══██╗██║   ██║██╔══╝     ██║   
--╚██████╔╝██╔╝ ██╗       ██║   ██║  ██║██║  ██║╚██████╔╝███████╗   ██║   
-- ╚═════╝ ╚═╝  ╚═╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
                                                                
useoxtarget = true,

userepairtarget = true, -- Si vous voulez l'intégration de la fonction "Réparer" avec ox_target
usecleantarget = true, -- Si vous voulez l'intégration de la fonction "Nettoyer" avec ox_target
userefuelltarget = true, -- Si vous voulez l'intégration de la fonction "Remplire le réservoir" avec ox_target
useimpoundtarget = true, -- Si vous voulez l'intégration de la fonction "Mise en fourrière" avec ox_target


--██████╗ ██████╗  ██████╗  ██████╗ ██████╗ ███████╗███████╗███████╗██████╗  █████╗ ██████╗ 
--██╔══██╗██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗
--██████╔╝██████╔╝██║   ██║██║  ███╗██████╔╝█████╗  ███████╗███████╗██████╔╝███████║██████╔╝
--██╔═══╝ ██╔══██╗██║   ██║██║   ██║██╔══██╗██╔══╝  ╚════██║╚════██║██╔══██╗██╔══██║██╔══██╗
--██║     ██║  ██║╚██████╔╝╚██████╔╝██║  ██║███████╗███████║███████║██████╔╝██║  ██║██║  ██║
--╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
                                                                                          
progressbar = true,
customprogressbar = function(time, message)
    timeseconde = time/1000 -- Uniquement pour les progressbar en seconde
   
    exports['an_progBar']:run(timeseconde,message)
    Wait(time) -- Si votre progress bar à besoin d'un wait
end,

--███████╗███████╗███████╗███████╗███╗   ██╗ ██████╗███████╗
--██╔════╝██╔════╝██╔════╝██╔════╝████╗  ██║██╔════╝██╔════╝
--█████╗  ███████╗███████╗█████╗  ██╔██╗ ██║██║     █████╗  
--██╔══╝  ╚════██║╚════██║██╔══╝  ██║╚██╗██║██║     ██╔══╝  
--███████╗███████║███████║███████╗██║ ╚████║╚██████╗███████╗
--╚══════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝
                                                          
essencefunction = function(levelfuel)
    -- Veuillez mettre votre export pour mettre de l'essence dans le véhicule
end,

--███████╗ █████╗  ██████╗████████╗██╗   ██╗██████╗ ███████╗
--██╔════╝██╔══██╗██╔════╝╚══██╔══╝██║   ██║██╔══██╗██╔════╝
--█████╗  ███████║██║        ██║   ██║   ██║██████╔╝█████╗  
--██╔══╝  ██╔══██║██║        ██║   ██║   ██║██╔══██╗██╔══╝  
--██║     ██║  ██║╚██████╗   ██║   ╚██████╔╝██║  ██║███████╗
--╚═╝     ╚═╝  ╚═╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝

useothersystem = false, -- Systeme de base : esx_billing (si vous utilisez autre chose, mettez sur false)
facturecustom = function(price)
    local ClosestPlayer, distance = ESX.Game.GetClosestPlayer()
    if ClosestPlayer ~= -1 and distance <= 3.0 then
        if price ~= nil and type(price) == 'number' then
            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
              Citizen.Wait(4000)
              ClearPedTasks(PlayerPedId())
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(ClosestPlayer), 'society_mechanic', 'Otto Mechanic', price)
                ESX.ShowNotification("~g~Vous avez envoyée une facture au montant de "..price.."$")
        else
            ESX.ShowNotification("~r~Montant invalide")
        end
    else
        ESX.ShowNotification("~r~Aucun joueur à proximité")
    end
end, 

--██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗
--██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  
--██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  
--╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

Garage = {
    usetarget = true, -- Utiliser ox_target pour intéragir avec le PNJ
    position = vector3(-192.65385437012, -1293.5789794922, 31.295986175537),
    pedmodel = "ig_benny", -- https://docs.fivem.net/docs/game-references/ped-models/
    pedposition = {x = -193.1171875, y = -1293.6099853516, z = 31.295986175537, h = 270.3843078613281},

    spawncar = {x = -180.05906677246, y = -1288.4125976563, z = 31.295988082886},
    spawnheading = 181.99986267089844,

    rangerposition = {x = -190.41827392578, y = -1290.3055419922, z = 31.295993804932},

    usecustomcamera = true,
    usepreview = true,
    poscamera = {x = -183.83149719238, y = -1296.4932861328, z = 31.295986175537},

    ListeVehicle = {
        {label = "Dépanneuse à plateau", model = "flatbed"},
        {label = "Véhicule de déplacement", model = "slamvan"},
    },

    usekeysystem = true, -- Si vous souhaitez pouvoir intégrer votre systeme de clé
    keygivefonction = function(plate) -- Fonction pour obtenir la clé
    end,
    keyremovefonction = function(plate) -- Fonction pour destituer la clé
    end
},

--██████╗  ██████╗ ███████╗███████╗
--██╔══██╗██╔═══██╗██╔════╝██╔════╝
--██████╔╝██║   ██║███████╗███████╗
--██╔══██╗██║   ██║╚════██║╚════██║
--██████╔╝╚██████╔╝███████║███████║
--╚═════╝  ╚═════╝ ╚══════╝╚══════╝

Boss = {
    position = {x = -206.93125915527, y = -1341.5377197266, z = 34.894355773926},

    usetarget = true,
    usemarker = false,
    usecustomboss = false,
    opencustomboss = function()
    end
},
                                 

--██████╗ ██████╗ ███████╗███████╗██████╗ ███████╗
--██╔════╝██╔═══██╗██╔════╝██╔════╝██╔══██╗██╔════╝
--██║     ██║   ██║█████╗  █████╗  ██████╔╝█████╗  
--██║     ██║   ██║██╔══╝  ██╔══╝  ██╔══██╗██╔══╝  
--╚██████╗╚██████╔╝██║     ██║     ██║  ██║███████╗
-- ╚═════╝ ╚═════╝ ╚═╝     ╚═╝     ╚═╝  ╚═╝╚══════╝

Coffre = {
    position = {x = -196.84788513184, y = -1314.6680908203, z = 31.089384078979},

    usetarget = true,
    usemarker = false,
    usecustomcoffre = true, -- Si vous utilisez un inventaire UI (Exemple : ox_inventory)
    customopencoffre = function()
        exports.ox_inventory:openInventory('stash', {id='society_mechanic', "mechanic"})
    end,
},

--██╗   ██╗███████╗███████╗████████╗██╗ █████╗ ██╗██████╗ ███████╗
--██║   ██║██╔════╝██╔════╝╚══██╔══╝██║██╔══██╗██║██╔══██╗██╔════╝
--██║   ██║█████╗  ███████╗   ██║   ██║███████║██║██████╔╝█████╗  
--╚██╗ ██╔╝██╔══╝  ╚════██║   ██║   ██║██╔══██║██║██╔══██╗██╔══╝  
-- ╚████╔╝ ███████╗███████║   ██║   ██║██║  ██║██║██║  ██║███████╗
--  ╚═══╝  ╚══════╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝
                                                                
Vestiaire = {
    position = {x = -224.26377868652, y = -1319.8637695313, z = 30.89041519165},

    usetarget = true,
    usemarker = false,
    usecustomvestiaire = false, -- Si vous utilisez un systeme de vestiaire spécifique
    customvestiaire = function()
    end,

    MecanoOutfit = {
        clothes = {
                    [1] = {
                        minimum_grade = 0,
                        label = "Tenue Service",
                        variations = {
                        male = {
                            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                            ['torso_1'] = 66,   ['torso_2'] = 0,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 38,
                            ['pants_1'] = 39,   ['pants_2'] = 0,
                            ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        },
                        female = {
                            ['tshirt_1'] = 103,  ['tshirt_2'] = 0,
                            ['torso_1'] = 230,   ['torso_2'] = 0,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 215,
                            ['pants_1'] = 30,   ['pants_2'] = 0,
                            ['shoes_1'] = 25,   ['shoes_2'] = 0,
                            ['helmet_1'] = 149,  ['helmet_2'] = 0,
                            ['chain_1'] = 0,    ['chain_2'] = 0,
                            ['mask_1'] = 185,  ['mask_2'] = 0,
                            ['bproof_1'] = 0,  ['bproof_2'] = 0,
                            ['ears_1'] = -1,     ['ears_2'] = 0,
                            ['bproof_1'] = 27,  ['bproof_2'] = 0,
                            ['glasses_1'] = 22
                       }
                   },
                    onEquip = function()
                end
             }
        }
    }
},

--███████╗████████╗ █████╗ ██████╗ ██╗     ██╗
--██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██║     ██║
--█████╗     ██║   ███████║██████╔╝██║     ██║
--██╔══╝     ██║   ██╔══██║██╔══██╗██║     ██║
--███████╗   ██║   ██║  ██║██████╔╝███████╗██║
--╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝

Etabli = {
    position = {x = -227.83442687988, y = -1327.6368408203, z = 30.890419006348},

    usetarget = true,
    usemarker = false,
    usecustomcraft = false,
    customcraft = function()
    end,

    payforcraftreparationkit = false, -- Si vous voulez crafter un kit en payant (cela désactive la chaine de farm et cela concernent le kit de réparation étant le seul kit farm)
    needforcraft = {
        ferraille = 2,
        acier = 2,
    },

    pricekitreparation = 2, -- (Optionnel si payforcraft = false)
    pricekitnettoyage = 5,

    ferraillerequis = 2,
    acierrequis = 2,

},
          
--███████╗ █████╗ ██████╗ ███╗   ███╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║
--█████╗  ███████║██████╔╝██╔████╔██║
--██╔══╝  ██╔══██║██╔══██╗██║╚██╔╝██║
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝

Farm = {
    positionferraille = {x = -549.220703125, y = -1716.9757080078, z = 18.848989486694},
    positionacier = {x = -444.12780761719, y = -1711.5316162109, z = 18.758008956909},

    usetarget = true,
    usemarker = false,
},
                 
--███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗
--████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║
--██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║
--██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║
--██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║
--╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝

MissionPnj = true,
NPCSpawnDistance = 100.0,  
NPCNextToDistance = 25.0,
NPCJobEarnings = { min = 15, max = 40 },

Zones = { 
    VehicleDelivery = {  
		Pos   = {x = -163.10093688965, y = -1305.8044433594, z = 31.352502822876},
		Size  = { x = 20.0, y = 20.0, z = 3.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}													
},

Towables = {
	vector3(-2480.9, -212.0, 17.4),
	vector3(-2723.4, 13.2, 15.1),
	vector3(-3169.6, 976.2, 15.0),
	vector3(-3139.8, 1078.7, 20.2),
	vector3(-1656.9, -246.2, 54.5),
	vector3(-1586.7, -647.6, 29.4),
	vector3(-1036.1, -491.1, 36.2),
	vector3(-1029.2, -475.5, 36.4),
	vector3(75.2, 164.9, 104.7),
	vector3(-534.6, -756.7, 31.6),
	vector3(487.2, -30.8, 88.9),
	vector3(-772.2, -1281.8, 4.6),
	vector3(-663.8, -1207.0, 10.2),
	vector3(719.1, -767.8, 24.9),
	vector3(-971.0, -2410.4, 13.3),
	vector3(-1067.5, -2571.4, 13.2),
	vector3(-619.2, -2207.3, 5.6),
	vector3(1192.1, -1336.9, 35.1),
	vector3(-432.8, -2166.1, 9.9),
	vector3(-451.8, -2269.3, 7.2),
	vector3(939.3, -2197.5, 30.5),
	vector3(-556.1, -1794.7, 22.0),
	vector3(591.7, -2628.2, 5.6),
	vector3(1654.5, -2535.8, 74.5),
	vector3(1642.6, -2413.3, 93.1),
	vector3(1371.3, -2549.5, 47.6),
	vector3(383.8, -1652.9, 37.3),
	vector3(27.2, -1030.9, 29.4),
	vector3(229.3, -365.9, 43.8),
	vector3(-85.8, -51.7, 61.1),
	vector3(-4.6, -670.3, 31.9),
	vector3(-111.9, 92.0, 71.1),
	vector3(-314.3, -698.2, 32.5),
	vector3(-366.9, 115.5, 65.6),
	vector3(-592.1, 138.2, 60.1),
	vector3(-1613.9, 18.8, 61.8),
	vector3(-1709.8, 55.1, 65.7),
	vector3(-521.9, -266.8, 34.9),
	vector3(-451.1, -333.5, 34.0),
	vector3(322.4, -1900.5, 25.8)
},

Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo',
	'sultan',
	'baller3'
},                                                                                                 
}

for k,v in ipairs(Config.Towables) do
	Config.Zones['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end