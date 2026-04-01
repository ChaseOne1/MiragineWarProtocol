local netoptions <const> = require("protocols.netoptions")

local M = {
    client = {
        guid = "",

        InquireFormationReq = function() return 128, netoptions.PacketPriority.IMMEDIATE_PRIORITY,
                netoptions.PacketReliability.RELIABLE, netoptions.PacketChannel.RPC end,

        -- [[id] = integer, ...]
        MyFormationSpawnNotify = function(formation_list) return 130, netoptions.InterfaceDefaultConfig() end,
        OpponentFormationSpawnNotify = function(formation_list) return 132, netoptions.InterfaceDefaultConfig() end,

        -- { coin = integer, income = integer, population = integer }
        MyResourcesStatusNotify = function(resources_map) return 134, netoptions.InterfaceDefaultConfig() end,
        OpponentResourcesStatusNotify = function(resources_map) return 136, netoptions.InterfaceDefaultConfig() end,
    },

    server = {
        -- [[[1] = integer, [...]]]
        InquireFormationRsp = function(formation_list) return 129, netoptions.InterfaceDefaultConfig() end
    }
}

require("service").setup(
    require("protocols.services").CombatService,
    M
)

return M
