-- Thank you Nazdravi for the idea.
-- You can change the config here, the keybind can be set ingame by going into your settings > keybinds > FiveM > and set your keybind for AI Killswitch.

-- Kill switch duration.
-- 15000 = 15 seconds. 
-- 1000 = 1 second.
KillswitchTimer = 15000

-- Size in meters.
Size = 55.0

-- Vehicle speed in the zone. 0 makes it a kill switch basically idk why u would use more.
Speed = 0.0

-- Hide or show messages when it turns on and off.
-- Show = 1 | Hide = 0
KillswitchOnMsg = 1
KillswitchOffMsg = 1

-- 1 = makes a transparent white blip on the map. 0 = doesn't make one.
TurnBlipOn = 1





-- No need to touch anything below this unless u rlly want to then ok idc.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

function Notify(Text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(Text)
    DrawNotification(true, true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            RegisterCommand('+Killswitch', function()
                local ped = PlayerPedId()
                if DoesEntityExist(ped) and not IsEntityDead(ped) then
                    if not IsPauseMenuActive() then 
                        if Zone == nil then
                            Zone = AddSpeedZoneForCoord(GetEntityCoords(PlayerPedId()), Size, Speed, false)
                            if TurnBlipOn == 1 then
                                Area = AddBlipForRadius(GetEntityCoords(PlayerPedId()), Size)
                            end
                            SetBlipAlpha(Area, 100)
                            if KillswitchOnMsg == 1 then
                                Notify("Vehicle killswitch: ~r~on")
                            end
                            Wait(KillswitchTimer)
                            RemoveSpeedZone(Zone)
                            if TurnBlipOn == 1 then
                                RemoveBlip(Area)
                            end
                            Zone = nil
                            if KillswitchOffMsg == 1 then
                                Notify("Vehicle killswitch: ~g~off")
                            end
                        end
                    end
                end
            end)
    end
end)

RegisterKeyMapping('+Killswitch', 'AI Killswitch', 'keyboard', 'Keybind')