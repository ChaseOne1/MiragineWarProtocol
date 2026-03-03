local config<const> = require("protocols.netoptions").InterfaceDefaultConfig

local M = {
    client = {
        guid = nil,
        MatchmakingRsp = function(another_name) return 128, config() end
    },

    server = {
        MatchmakingReq = function(my_name) return 129, config() end
    }
}

require("service").setup(
    require("protocols.services").MatchmakingService,
    M
)

return M
