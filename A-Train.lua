--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

return (function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")

    local ZOOM_ID = "rbxassetid://77807683763606" 
    local CANT_STOP_ID = "rbxassetid://125117454142800"

    local isPlayingZoom = false

    if _G.ATrainActive then
        _G.ATrainActive = false
        hum.WalkSpeed = 16
        if _G.ZoomConnection then _G.ZoomConnection:Disconnect() end
        if root:FindFirstChild("ZoomSound") then root.ZoomSound:Destroy() end
        
        local s = Instance.new("Sound", root)
        s.SoundId = CANT_STOP_ID
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)
    else
        _G.ATrainActive = true
        hum.WalkSpeed = 250
        
        local zoom = Instance.new("Sound", root)
        zoom.Name = "ZoomSound"
        zoom.SoundId = ZOOM_ID
        
        _G.ZoomConnection = hum.Running:Connect(function(speed)
            if speed > 0.5 then
                if not isPlayingZoom then
                    isPlayingZoom = true
                    zoom:Play()
                end
            else
                isPlayingZoom = false
                zoom:Stop()
            end
        end)
    end
end)()