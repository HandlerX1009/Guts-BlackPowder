local GUI = loadstring(game:HttpGet(("https://raw.githubusercontent.com/HandlerX1009/Guts-BlackPowder/refs/heads/main/Required/UI/lib.luau")))()

local MainWindow = GUI:CreateWindow("G&BP Manipulator | PRIVATE | Love from Unlisted <3", false)

--------------------------------------------------------------
local BindTab = MainWindow:NewTab(" Exploit Keybinds", true)

local BlatantLabel = BindTab:NewLabel("Blatant Toggles", true)
local Bind_Enable = BindTab:NewParagraph("Enabler/Disabler - R", 0.05, 15)
local Bind_AutoRotate = BindTab:NewParagraph("AutoRotate - X", 0, 15)
local Bind_HitBombs = BindTab:NewParagraph("HitBombers - B", 0.05, 15)
local Bind_Charging = BindTab:NewParagraph("Charging Enabler/Disabler  - G", 0, 15)
local Bind_AutoRepair = BindTab:NewParagraph("AutoRepair - H", 0.05, 15)
--------------------------------------------------------------

local InfoTab = MainWindow:NewTab("Game Information")

local KillCount = InfoTab:NewParagraph("Kills: ???")
local ZombieCount = InfoTab:NewParagraph("Zombies: ???")
local InfectionCount = InfoTab:NewParagraph("Infection Amount: ???/100")
local RoundsCount = InfoTab:NewParagraph("Rounds Alive: ???")
local HeatCount = InfoTab:NewParagraph("Heat Amount: ???")
local BurnMultCount = InfoTab:NewParagraph("Burn Multiplier: ???")
local BurnCount = InfoTab:NewParagraph("Burn Amount: ???")
local BaseSpeedCount = InfoTab:NewParagraph("BaseSpeed: ???")
local MaxSpeedCount = InfoTab:NewParagraph("MaxSpeed: ???")
--------------------------------------------------------------

--[[------------------------------------------------------]]--
local GUIReturn = {
    ["KillCount"] = {KillCount,  "Kills: %.2f"},
    ["ZombieCount"] = {ZombieCount, "Zombies: %.2f"},
    ["InfectionCount"] = {InfectionCount, "Infection Amount: %.2f/100.00"},
    ["RoundsCount"] = {RoundsCount, "Rounds Alive: %.2f"},
    ["HeatCount"] = {HeatCount, "Heat Amount: %.2f"},
    ["BurnMultCount"] = {BurnMultCount, "Burn Multiplier: %.2f"},
    ["BurnCount"] = {BurnCount, "Burn Amount: %.2f"},
    ["BaseSpeedCount"] = {BaseSpeedCount, "BaseSpeed: %.2f"},
    ["MaxSpeedCount"] = {MaxSpeedCount, "MaxSpeed: %.2f"},
}

return GUIReturn
--[[------------------------------------------------------]]--
