local M = {
    PacketPriority = {
        IMMEDIATE_PRIORITY   = 0,
        HIGH_PRIORITY        = 1,
        MEDIUM_PRIORITY      = 2,
        LOW_PRIORITY         = 3,
        NUMBER_OF_PRIORITIES = 4,
    },

    PacketReliability = {
        UNRELIABLE                        = 0,
        UNRELIABLE_SEQUENCED              = 1,
        RELIABLE                          = 2,
        RELIABLE_ORDERED                  = 3,
        RELIABLE_SEQUENCED                = 4,
        UNRELIABLE_WITH_ACK_RECEIPT       = 5,
        RELIABLE_WITH_ACK_RECEIPT         = 6,
        RELIABLE_ORDERED_WITH_ACK_RECEIPT = 7,
        NUMBER_OF_RELIABILITIES           = 8,
    },

    PacketChannel = {
        RPC = 1,
    },

    InterfaceDefaultConfig = function () end
}

M.InterfaceDefaultConfig = function() return
    M.PacketPriority.HIGH_PRIORITY,
    M.PacketReliability.RELIABLE,
    M.PacketChannel.RPC
end

return M
