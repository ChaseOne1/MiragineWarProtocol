cmake_minimum_required(VERSION 3.26)
project(MiragineWarProtocol VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

set(BUILD_SHARED_LIBS OFF)
set(protobuf_WITH_ZLIB OFF)
add_subdirectory(3rdlibs/protobuf)

if(NOT TARGET protobuf::protoc)
    message(FATAL_ERROR "No protoc target found")
endif ()

set(PROTOS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/protos)
file(GLOB_RECURSE PROTO_FILES CONFIGURE_DEPENDS ${PROTOS_DIR}/*.proto)
set(CXX_PROTOS_INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
set(CXX_PROTOS_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/protocol)
file(MAKE_DIRECTORY ${CXX_PROTOS_SRC_DIR})
file(COPY_FILE ${CMAKE_CURRENT_SOURCE_DIR}/PacketOpcodes.hpp ${CXX_PROTOS_SRC_DIR}/PacketOpcodes.hpp ONLY_IF_DIFFERENT)

set(CXX_PROTOS_SRC)
set(CXX_PROTOS_HDR)
foreach (PROTO_FILE ${PROTO_FILES})
    get_filename_component(FILE_NAME ${PROTO_FILE} NAME_WE)

    set(CURRENT_CC ${CXX_PROTOS_SRC_DIR}/${FILE_NAME}.pb.cc)
    set(CURRENT_H ${CXX_PROTOS_SRC_DIR}/${FILE_NAME}.pb.h)


    add_custom_command(
            OUTPUT ${CURRENT_CC} ${CURRENT_H}
            COMMAND protobuf::protoc
            -I=${PROTOS_DIR}
            -I=${protobuf_SOURCE_DIR}/src
            --cpp_out=${CXX_PROTOS_SRC_DIR}
            ${PROTO_FILE}
            DEPENDS ${PROTO_FILE}
            COMMENT "Generating C++ protobuf files from ${PROTO_FILE}"
    )

    list(APPEND CXX_PROTOS_SRC ${CURRENT_CC})
    list(APPEND CXX_PROTOS_HDR ${CURRENT_H})
endforeach ()

add_library(MiragineWarProtocol STATIC ${CXX_PROTOS_SRC} ${CXX_PROTOS_HDR})
add_library(MWProtocol::MWProtocol ALIAS MiragineWarProtocol)
target_link_libraries(MiragineWarProtocol PUBLIC protobuf::libprotobuf)
target_include_directories(MiragineWarProtocol  PUBLIC ${CXX_PROTOS_INC_DIR})