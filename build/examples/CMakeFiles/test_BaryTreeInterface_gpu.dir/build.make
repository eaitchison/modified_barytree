# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake3

# The command to remove a file.
RM = /usr/bin/cmake3 -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ewa19/RISM/barytree/BaryTree-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ewa19/RISM/barytree/BaryTree-master/build

# Include any dependencies generated for this target.
include examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/flags.make

examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.o: examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/flags.make
examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.o: ../examples/test_BaryTreeInterface.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ewa19/RISM/barytree/BaryTree-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.o"
	cd /home/ewa19/RISM/barytree/BaryTree-master/build/examples && /home/ewa19/RISM/hpc_sdk/Linux_x86_64/21.5/compilers/bin/pgcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.o   -c /home/ewa19/RISM/barytree/BaryTree-master/examples/test_BaryTreeInterface.c

examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.i"
	cd /home/ewa19/RISM/barytree/BaryTree-master/build/examples && /home/ewa19/RISM/hpc_sdk/Linux_x86_64/21.5/compilers/bin/pgcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ewa19/RISM/barytree/BaryTree-master/examples/test_BaryTreeInterface.c > CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.i

examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.s"
	cd /home/ewa19/RISM/barytree/BaryTree-master/build/examples && /home/ewa19/RISM/hpc_sdk/Linux_x86_64/21.5/compilers/bin/pgcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ewa19/RISM/barytree/BaryTree-master/examples/test_BaryTreeInterface.c -o CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.s

# Object files for target test_BaryTreeInterface_gpu
test_BaryTreeInterface_gpu_OBJECTS = \
"CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.o"

# External object files for target test_BaryTreeInterface_gpu
test_BaryTreeInterface_gpu_EXTERNAL_OBJECTS =

bin/test_BaryTreeInterface_gpu: examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/test_BaryTreeInterface.c.o
bin/test_BaryTreeInterface_gpu: examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/build.make
bin/test_BaryTreeInterface_gpu: lib/libBaryTree_gpu.so
bin/test_BaryTreeInterface_gpu: /home/ewa19/RISM/hpc_sdk/Linux_x86_64/21.5/compilers/lib/libacchost.so
bin/test_BaryTreeInterface_gpu: /opt/openmpi/lib/libmpi.so
bin/test_BaryTreeInterface_gpu: examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ewa19/RISM/barytree/BaryTree-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable ../bin/test_BaryTreeInterface_gpu"
	cd /home/ewa19/RISM/barytree/BaryTree-master/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_BaryTreeInterface_gpu.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/build: bin/test_BaryTreeInterface_gpu

.PHONY : examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/build

examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/clean:
	cd /home/ewa19/RISM/barytree/BaryTree-master/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/test_BaryTreeInterface_gpu.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/clean

examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/depend:
	cd /home/ewa19/RISM/barytree/BaryTree-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ewa19/RISM/barytree/BaryTree-master /home/ewa19/RISM/barytree/BaryTree-master/examples /home/ewa19/RISM/barytree/BaryTree-master/build /home/ewa19/RISM/barytree/BaryTree-master/build/examples /home/ewa19/RISM/barytree/BaryTree-master/build/examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/test_BaryTreeInterface_gpu.dir/depend
