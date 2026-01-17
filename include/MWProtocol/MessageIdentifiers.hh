#pragma once
#include <cstdint>

namespace proto {
enum MessageID : std::uint8_t
{
    ID_USER_PACKET_ENUM = 134,
    ID_MESSAGE_ECHO,
    ID_RPC_CALL,
};
}
