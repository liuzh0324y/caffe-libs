cmake_minimum_required(VERSION 2.8)

project(boost)

set(boost_root ${CMAKE_CURRENT_SOURCE_DIR}/boost_1_56_0)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DNO_BZIP2")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNO_BZIP2 -std=c++11 -Wunused-variable")

include_directories(${boost_root})

# boost_system
file(GLOB lib_srcs ${boost_root}/libs/system/src/*.cpp)

add_library(boost_system SHARED ${lib_srcs})

# boost_filesystem
file(GLOB lib_srcs ${boost_root}/libs/filesystem/src/*.cpp)

add_library(boost_filesystem SHARED ${lib_srcs})

# boost_iostreams
set(lib_dir ${boost_root}/libs/iostreams/src)
set(lib_srcs ${lib_dir}/file_descriptor.cpp ${lib_dir}/gzip.cpp ${lib_dir}/mapped_file.cpp ${lib_dir}/zlib.cpp)

add_library(boost_iostreams SHARED ${lib_srcs})

# boost_program_options
file(GLOB lib_srcs ${boost_root}/libs/program_options/src/*.cpp)

add_library(boost_program_options SHARED ${lib_srcs})

# boost_regex
file(GLOB lib_srcs ${boost_root}/libs/regex/src/*.cpp)

add_library(boost_regex SHARED ${lib_srcs})

# boost_signals
file(GLOB lib_srcs ${boost_root}/libs/signals/src/*.cpp)

add_library(boost_signals SHARED ${lib_srcs})

# boost_chrono
file(GLOB lib_srcs ${boost_root}/libs/chrono/src/*.cpp)

add_library(boost_chrono SHARED ${lib_srcs})

# boost_atomic
file(GLOB lib_srcs ${boost_root}/libs/atomic/src/*.cpp)

add_library(boost_atomic SHARED ${lib_srcs})

# boost_thread
#file(GLOB lib_srcs ${boost_root}/libs/thread/src/pthread/*.cpp)
set(lib_dir ${boost_root}/libs/thread/src)
set(lib_srcs ${lib_dir}/pthread/thread.cpp ${lib_dir}/pthread/once.cpp ${lib_dir}/future.cpp)

add_library(boost_thread SHARED ${lib_srcs})

# boost_date_time
file(GLOB lib_srcs ${boost_root}/libs/date_time/src/gregorian/*.cpp  ${boost_root}/libs/date_time/src/posix_time/*.cpp)

add_library(boost_date_time SHARED ${lib_srcs})

# boost_random
file(GLOB lib_srcs ${boost_root}/libs/random/src/*.cpp)

add_library(boost_random SHARED ${lib_srcs})

# boost_math
file(GLOB lib_srcs ${boost_root}/libs/math/src/tr1/*.cpp)
include_directories("${boost_root}/libs/math/src/tr1")

add_library(boost_math SHARED ${lib_srcs})

set(Boost_INCLUDE_DIRS ${boost_root})
set(Boost_LIBRARIES boost_filesystem boost_system boost_program_options boost_iostreams boost_chrono boost_regex boost_signals boost_atomic boost_date_time boost_random boost_math pthread)
set(Boost_LINK_DIRS ${LIBRARY_OUTPUT_PATH})

configure_file(${CMAKE_SOURCE_DIR}/boostconfig.cmake.in
               ${CMAKE_BINARY_DIR}/boostconfig.cmake @ONLY)

install(DIRECTORY ${boost_root}/boost DESTINATION include)
install(TARGETS boost_system DESTINATION lib)
install(TARGETS boost_filesystem DESTINATION lib)
install(TARGETS boost_program_options DESTINATION lib)
install(TARGETS boost_iostreams DESTINATION lib)
install(TARGETS boost_chrono DESTINATION lib)
install(TARGETS boost_regex DESTINATION lib)
install(TARGETS boost_signals DESTINATION lib)
install(TARGETS boost_thread DESTINATION lib)
install(TARGETS boost_date_time DESTINATION lib)
install(TARGETS boost_atomic DESTINATION lib)
install(TARGETS boost_random DESTINATION lib)
install(TARGETS boost_math DESTINATION lib)
