local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local DS_KEY = require(script.Parent.dskey)
local DS_service = s.dss
local DS = DS_service.GetDataStore(DS_KEY)

-- Server Data Storage
SDS = {}

-- Related Functions
function SDS.mountPlayer(Player)
    -- This function will get the Player's data from the cloud as the Player joins, as not to overpopulate the script with unneccessary indexes
    local PlayerData = DS:GetAsync(Player.UserId)
    if PlayerData == nil then
        PlayerData = {}
        DS:SetAsync(Player.UserId, PlayerData)
    end
    SDS[Player.UserId] = PlayerData
end
    
function SDS.dismountPlayer(Player)
    -- This function will eliminate the Player's data from the SDS module since it is no longer needed
    SDS[Player.UserId] = nil
end

return SDS