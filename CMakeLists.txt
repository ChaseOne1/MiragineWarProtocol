cmake_minimum_required(VERSION 3.26)
project(MiragineWarProtocol VERSION 0.1.0 LANGUAGES CXX)

add_library(MiragineWarProtocol INTERFACE)
add_library(MWProtocol::MWProtocol ALIAS MiragineWarProtocol)

target_include_directories(MiragineWarProtocol INTERFACE include)
