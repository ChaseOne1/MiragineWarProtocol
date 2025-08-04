#pragma once

namespace proto {
enum PacketOpcode : unsigned char
{
    ID_USER_PACKET_ENUM = 134,
    ID_SHOW_MESSAGE_NOTIFY,
    ID_MATCHMAKING_REQ,
    ID_MATCHMAKING_RSP,
};
}
