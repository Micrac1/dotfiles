cmake_minimum_required(VERSION 3.30)

########################################
## Project settings                   ##
########################################
set(PROJECT_NAME MyProject)

# set(CMAKE_BUILD_TYPE "Debug")
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_LIBRARIES "")

# global compile options
add_compile_options(
  -Wall
  -Wextra
  -Wpedantic
  -Winvalid-pch
  -Wshadow
  -Wsign-compare
  $<$<CONFIG:Debug>:-g3>
)

########################################

project(${PROJECT_NAME})
add_compile_definitions($<$<CONFIG:DEBUG>:DEBUG>)

# Sources to build the main executable
file(GLOB_RECURSE SRCS CONFIGURE_DEPENDS RELATIVE ${CMAKE_SOURCE_DIR} src/*.cpp)

# Sources to build tests
file(GLOB_RECURSE TEST_SRCS CONFIGURE_DEPENDS RELATIVE ${CMAKE_SOURCE_DIR} ${SRCS} tests/*.cpp)
list(REMOVE_ITEM TEST_SRCS src/main.cpp)

# Assets to be copied
file(GLOB_RECURSE ASSETS RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/assets/*)
foreach(ITEM ${ASSETS})
  configure_file(${ITEM} ${CMAKE_CURRENT_BINARY_DIR}/${ITEM} COPYONLY)
endforeach()

########################################
## Submodules                         ##
########################################
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/modules")
# OpenGL
# set(OpenGL_GL_PREFERENCE GLVND)


# SDL2
# set(SDL2_DISABLE_INSTALL ON)
# set(SDL2_DISABLE_UNINSTALL ON)
# set(SDL_TEST OFF)
# set(SDL_STATIC OFF)
# add_subdirectory("modules/sdl")

# Assimp
# set(ASSIMP_BUILD_ZLIB ON)
# set(ASSIMP_NO_EXPORT OFF)
# set(ASSIMP_BUILD_TESTS OFF)
# set(ASSIMP_INSTALL OFF)
# add_subdirectory("modules/assimp")

# Glew
# add_subdirectory("modules/glew")


########################################
## Targets                            ##
########################################

# Main project
add_executable(core ${SRCS})
target_precompile_headers(core PUBLIC src/pch.h)

# Tests
add_executable(tests ${TEST_SRCS})
target_include_directories(tests PRIVATE src)
target_precompile_headers(tests REUSE_FROM core)
target_link_options(tests PRIVATE
  -lgtest
)

# Documentation
find_package(Doxygen)
# .txt to avoid accidental doxygen runs that would generate doc folder inside docs
set(DOXYFILE_IN ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.txt)
add_custom_target(doc
  $<$<CONFIG:Release>:ALL>
  COMMAND
  ${CMAKE_COMMAND} -E env DOXYGEN_INPUT=${CMAKE_CURRENT_SOURCE_DIR} ${DOXYGEN_EXECUTABLE} ${DOXYFILE_IN}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Generating documentation with Doxygen"
  VERBATIM
)
# Use this to make documentation ONLY in release mode
# $<$<CONFIG:Release>:${DOXYGEN_EXECUTABLE} ${DOXYFILE_IN}>
