cmake_minimum_required(VERSION 3.26)
project(MiragineWarProtocol VERSION 0.1.0 LANGUAGES CXX)

add_library(MiragineWarProtocol INTERFACE)
add_library(MWProtocol::MWProtocol ALIAS MiragineWarProtocol)

target_include_directories(MiragineWarProtocol INTERFACE include)

if(DEFINED SCRIPT_INSTALL_DIR)
    add_custom_target(
        copy_protocols ALL
        COMMAND ${CMAKE_COMMAND} -E make_directory ${SCRIPT_INSTALL_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/protocols ${SCRIPT_INSTALL_DIR}/protocols
        COMMENT "Copying protocols directory to ${SCRIPT_INSTALL_DIR}"
        VERBATIM
    )
    add_dependencies(MiragineWarProtocol copy_protocols)
else()
    message(NOTICE "SCRIPT_INSTALL_DIR is not defined. Protocols directory will not be copied.")
endif()
