local cruiseEnabled = false
local isDead = false

if Config.Speed  == "km" then
    speed = 3.6
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 29) and not isDead then
            local ped = PlayerPedId()
            local inVehicle = IsPedSittingInAnyVehicle(ped)
            local vehicle = GetVehiclePedIsIn(ped, false)
            local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
            local cruiserSpeed = GetEntitySpeed(vehicle)

            Wait(250)

            if not inVehicle then
                return
            end

            if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
                return
            end

            if not cruiseEnabled then
                SetEntityMaxSpeed(vehicle, cruiserSpeed)
                cruiserNotification = math.floor(cruiserSpeed * speed + 0.5)
                cruiseEnabled = true
                exports['nyZRP107']:DoLongHudText('inform', ('کروز کنترل خودرو فعال شد'))
            else
                SetEntityMaxSpeed(vehicle, maxSpeed)
                cruiseEnabled = false
                exports['nyZRP107']:DoLongHudText('inform', ('کروز کنترل خودرو غیرفعال شد'))
            end
		end
	end
end)
