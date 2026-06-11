--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local ZOOM_ID = "rbxassetid://77807683763606
local CANT_STOP_ID = "rbxassetid://125117454142800"

local isATrain = false
local zoomSound = nil

-- Create Sound Helper
local function playSound(id, parent)
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Parent = parent
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
    return s
end

-- Toggle Logic
if isATrain then
    -- Stop
    isATrain = false
    hum.WalkSpeed = 16
    if zoomSound then zoomSound:Stop() zoomSound:Destroy() end
    playSound(CANT_STOP_ID, root)
else
    -- Start
    isATrain = true
    hum.WalkSpeed = 250
    zoomSound = playSound(ZOOM_ID, root)
    zoomSound.Looped = true
end
