#pragma once
#include "MessageIdentifiers.hh"

namespace proto {
#pragma pack(push, 1)
struct PositionSyncPacketHeader {
    MessageID m_id_timestamp;
    std::uint64_t m_timestamp;
    MessageID m_id_positon_sync;
};

using PositionSyncPacketFlags_t = std::uint8_t;

struct PositionSyncPacketFlags {
    bool invalid : 1;
    bool velocity : 1;
    bool _1 : 1;
    bool _2 : 1;
    bool _3 : 1;
    bool _4 : 1;
    bool _5 : 1;
    bool _6 : 1;
};


constexpr std::uint32_t REMOTE_ID_MIN = 0u, REMOTE_ID_MAX = 1024u;
struct PositionSyncPacketEnt {
    std::uint16_t m_remote_id : 10;
    PositionSyncPacketFlags m_flags;
};

constexpr float POSITION_X_MIN = 0.f, POSITION_X_MAX = 1024.f;
constexpr float POSITION_Y_MIN = 0.f, POSITION_Y_MAX = 256.f;
struct PositionSyncPacketPos {
    std::uint16_t m_position_x; // float:[0, 1024]
    std::uint16_t m_position_y; // float:[0, 256]
};


constexpr float VELOCITY_X_MIN = -1024.f, VELOCITY_X_MAX = 1024.f;
constexpr float VELOCITY_Y_MIN = 0.f, VELOCITY_Y_MAX = 256.f;
// Optional by flags
struct PositionSyncPacketVel {
    std::uint16_t m_velocity_x; // float:[-1024, 1024]
    std::uint16_t m_velocity_y; // float:[0, 256]
};
#pragma pack(pop)
}
