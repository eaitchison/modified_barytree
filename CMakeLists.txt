cmake_minimum_required(VERSION 3.9...3.14)
project(BaryTree VERSION 1.1 LANGUAGES C CXX)

set(default_build_type "Release")

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
        STRING "Choose the type of build." FORCE)

    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
                "Debug" "Release" "None")
endif()
 
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)

option(BUILD_EXAMPLES "build examples with Zoltan"              ON)
option(ENABLE_ACC_BUILD "build OPENACC GPU version"             ON)
option(ENABLE_CUDA_BUILD "build CUDA GPU version"               ON)
option(BUILD_SHARED_LIBS "build libraries as shared objects"	ON)
message( "Before MPI  ENABLE_CUDA_BUILD")

#find_package(MPI    REQUIRED)
#find_package(OpenMP REQUIRED)

if(BUILD_EXAMPLES OR BUILD_TESTS)
    find_package(Zoltan REQUIRED)
    add_library(Zoltan_Interface INTERFACE)
    target_link_libraries(Zoltan_Interface INTERFACE zoltan)
    target_include_directories(Zoltan_Interface INTERFACE ${Zoltan_INCLUDE_DIRS})
endif()

message( "Before ENABLE_CUDA_BUILD")
if(ENABLE_CUDA_BUILD)
    message( "IN ENABLE_CUDA_BUILD")
    enable_language(CUDA)
    find_package(CUDA 10.0 REQUIRED)
    add_library(CUDA_Interface INTERFACE)
    target_link_libraries(CUDA_Interface INTERFACE ${CUDA_LIBRARIES})
endif()
find_package(MPI    REQUIRED)
find_package(OpenMP REQUIRED)

#Some PGI versions seem to require a link flag for OpenMP
set_property(TARGET OpenMP::OpenMP_C APPEND
                                     PROPERTY
                                         INTERFACE_LINK_LIBRARIES
                                         $<$<C_COMPILER_ID:PGI>:-mp>) 

#Creating an interface for OpenACC
if(ENABLE_ACC_BUILD)
add_library(OpenACC_C INTERFACE)
set_property(TARGET OpenACC_C        PROPERTY
                                         INTERFACE_COMPILE_OPTIONS
                                         -acc
                                         -ta=tesla:ccall,cc60$<$<CONFIG:Debug>:,time>
                                         -Minfo)
set_property(TARGET OpenACC_C        PROPERTY
                                         INTERFACE_LINK_LIBRARIES
                                         -acc
                                         -ta=tesla:ccall,cc60)
endif()
if(ENABLE_ACC_BUILD AND NOT (CMAKE_C_COMPILER_ID MATCHES PGI))
    message(STATUS "GPU build requires PGI compilers! Turning GPU build off.")
    set(ENABLE_ACC_BUILD OFF CACHE BOOL "build OpenACC GPU version" FORCE)
endif()

enable_testing()
add_subdirectory(src)
add_subdirectory(examples)
add_subdirectory(tests)
