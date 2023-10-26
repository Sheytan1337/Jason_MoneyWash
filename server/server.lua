ESX = nil
-- TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('AddJasonMoney')
AddEventHandler('AddJasonMoney', function(Money, BlackMoney)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local GetBlackMoney = xPlayer.getAccount('black_money').money
    if Money <= GetBlackMoney then
        xPlayer.removeAccountMoney('black_money', BlackMoney)
        xPlayer.addMoney(Money)
        TriggerClientEvent('esx:showNotification', source, "Du hast ~r~"..BlackMoney.."$ ~c~ Schwarzgeld gewaschen und erhälst ~g~"..Money.."$ ~c~ sauberes Geld")
    end
end)
