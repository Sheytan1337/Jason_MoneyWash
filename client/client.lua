ESX  = nil
local open = false
ESX = exports["es_extended"]:getSharedObject()

local LaundererMenu = RageUI.CreateMenu("Geldwäsche", "Geld waschen")
LaundererMenu.EnableMouse = true
LaundererMenu:DisplayPageCounter(false)

local SliderPannel = {
    Minimum = 0,
    Index = 1,
}

LaundererMenu.Closed = function()  
    SliderPannel.Index = 1 
    RageUI.Visible(LaundererMenu, false)
    open = false
end 

local Percentage = 0.80
local Progress = nil 
local PercentagePannel = 0.0

function OpenLaundererMenu()
    if open then 
        open = false 
        RageUI.Visible(LaundererMenu,false)
        return
    else
        open = true 
        RageUI.Visible(LaundererMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(LaundererMenu, function()
                    -- Start Code...
                    RageUI.Button('Geld zum waschen', false , {RightLabel = "$"..SliderPannel.Index}, true , {})
                    RageUI.Button('Auszahlungsbetrag', false, {RightLabel = "$"..Round(SliderPannel.Index * Percentage), Color = { HightLightColor = { 0, 255, 0, 150 }, BackgroundColor = { 38, 85, 150, 160 } }}, true, {
                        onSelected = function() 
                            local GetHeading = GetEntityHeading(PlayerPedId())
                            if GetHeading ~= 9.30 then
                                SetEntityHeading(PlayerPedId(), 9.30)
                            end
                            SetEntityCoords(PlayerPedId(), 1122.4825439453,-3194.7829589844,-41.40)
                            Progress = true
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), true)
                            startAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer")
                            LaundererMenu.Closable = false
                        end
                    })
                            
                    RageUI.Separator("Ihr schmutziges Geld: ~g~$" .. ESX.PlayerData.accounts[3].money)
                    RageUI.SliderPanel(SliderPannel.Index, SliderPannel.Minimum, "Menge", ESX.PlayerData.accounts[3].money, {
                        onSliderChange = function(Index)
                            SliderPannel.Index = Index
                        end
                    }, 1)

                    if Progress == true then
                        RageUI.PercentagePanel(PercentagePannel, 'Geld wird gewaschen', '', '', {}, 2)
                        if PercentagePannel < 1.0 then
                            PercentagePannel = PercentagePannel + 0.0008
                        else
                            local FinalPercentage = Round(SliderPannel.Index * Percentage)
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)
                            Wait(50)
                            TriggerServerEvent('AddMoneyWash', FinalPercentage, SliderPannel.Index)
                            PercentagePannel = 0.0
                            Progress = false
                            LaundererMenu.Closable = true
                            LaundererMenu.Closed()
                        end
                    end
                end)
                Wait(0)
            end
        end)
    end
end

LaundererPosition = {
    {pos = vector3(1122.4825,-3194.7829,-41.40)},
}

CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local spam = false
        for _,v in pairs(LaundererPosition) do
            if #(pCoords - v.pos) < 1.2 then
                spam = true
                ESX.ShowHelpNotification('Drücke ~INPUT_PICKUP~ um Geld zu ~b~waschen')
                DrawMarker(25, v.pos , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.1, 1.1, 1.1, 27, 155, 207, 150, false, true, 2, false, false, false, false)
                if IsControlJustReleased(0, 38) then
                    RefreshPlayerData()
                    Wait(50)
                    OpenLaundererMenu()
                end                
            elseif #(pCoords - v.pos) < 1.3 then
                spam = false 
                LaundererMenu.Closed()  
            end
        end
        if spam then
            Wait(1)
        else
            Wait(500)
        end
    end
end)
