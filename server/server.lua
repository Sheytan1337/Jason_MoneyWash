ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('AddMoneyWash')
AddEventHandler('AddMoneyWash', function(Money, BlackMoney)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local GetBlackMoney = xPlayer.getAccount('black_money').money
    if Money <= GetBlackMoney then
        xPlayer.removeAccountMoney('black_money', BlackMoney)
        xPlayer.addMoney(Money)
        TriggerClientEvent('esx:showNotification', source, "Du hast ~r~"..BlackMoney.."$ ~c~ Schwarzgeld gewaschen und erhälst ~g~"..Money.."$ ~c~ sauberes Geld")
    end
end)
