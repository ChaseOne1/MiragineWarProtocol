cmake_minimum_required(VERSION 3.26)
project(MiragineWarProtocol)

set(PROTOS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/protos)
set(3RD_PROTOS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdprotos)
set(CXX_PROTOS_INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
set(CXX_PROTOS_DIR ${CXX_PROTOS_INC_DIR}/protocol)

file(MAKE_DIRECTORY ${CXX_PROTOS_DIR})
file(COPY_FILE ./PacketOpcodes.hpp ${CXX_PROTOS_DIR}/PacketOpcodes.hpp ONLY_IF_DIFFERENT)

set(CXX_PROTOS_SRC) # declare a list
file(GLOB_RECURSE PROTO_FILES CONFIGURE_DEPENDS ${PROTOS_DIR}/*.proto)
foreach(PROTO_FILE ${PROTO_FILES})
    get_filename_component(FILE_NAME ${PROTO_FILE} NAME_WE)
    set(CURRENT_CXXFILE ${CXX_PROTOS_DIR}/${FILE_NAME}.pb.cc)

    # call on each proto file to track changes individually
    add_custom_command(OUTPUT ${CURRENT_CXXFILE}
        COMMAND protoc -I=${PROTOS_DIR}
            -I=${3RD_PROTOS_DIR}
            --cpp_out=${CXX_PROTOS_DIR}
            ${PROTO_FILE}
        DEPENDS ${PROTO_FILE}
        COMMENT "Generating ${CURRENT_CXXFILE}"
        VERBATIM
    )

    list(APPEND CXX_PROTOS_SRC ${CURRENT_CXXFILE})
endforeach()


# to support generating them without building mian target
add_custom_target(MiragineWarCxxProtos ALL DEPENDS ${CXX_PROTOS_SRC})

set(MWP_CXX_PROTOS_INC_DIR ${CXX_PROTOS_INC_DIR} PARENT_SCOPE)
set(MWP_CXX_PROTOS_SRC ${CXX_PROTOS_SRC} PARENT_SCOPE)
