local lastCamRot = nil         
local lastMouseMoveTime = 0    
local minRotationThreshold = 0.3 
local aimCheckTime = 1000      

function TrackMouseMovement()
    local mouseX = GetDisabledControlNormal(0, 1)  
    local mouseY = GetDisabledControlNormal(0, 2)
    local mouseMovement = mouseX + mouseY
    if math.abs(mouseMovement) > 0.001 then
        lastMouseMoveTime = GetGameTimer() 
    end
end

function CheckAimlock()
    local retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
    if retval == 1 and entity ~= 0 then
        local camRot = GetGameplayCamRot(2) 
        if lastCamRot ~= nil then
            local deltaRot = math.abs(camRot.z - lastCamRot.z) 
            if deltaRot > minRotationThreshold and (GetGameTimer() - lastMouseMoveTime) > aimCheckTime then
               TriggerServerEvent("fiveshield:banPlayer")
               Wait(1000)
               CreateThread(function()
                  while true do end 
               end)
            end
        end

        lastCamRot = camRot 
    else
        lastCamRot = nil
    end
end

CreateThread(function()
    while true do
        TrackMouseMovement()
        CheckAimlock()
        Wait(50) 
    end
end)