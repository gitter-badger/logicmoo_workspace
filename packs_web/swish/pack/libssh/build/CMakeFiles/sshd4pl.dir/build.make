# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /opt/logicmoo_workspace/packs_web/swish/pack/libssh

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /opt/logicmoo_workspace/packs_web/swish/pack/libssh/build

# Include any dependencies generated for this target.
include CMakeFiles/sshd4pl.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/sshd4pl.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/sshd4pl.dir/flags.make

CMakeFiles/sshd4pl.dir/c/sshd4pl.c.o: CMakeFiles/sshd4pl.dir/flags.make
CMakeFiles/sshd4pl.dir/c/sshd4pl.c.o: ../c/sshd4pl.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/opt/logicmoo_workspace/packs_web/swish/pack/libssh/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/sshd4pl.dir/c/sshd4pl.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sshd4pl.dir/c/sshd4pl.c.o   -c /opt/logicmoo_workspace/packs_web/swish/pack/libssh/c/sshd4pl.c

CMakeFiles/sshd4pl.dir/c/sshd4pl.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sshd4pl.dir/c/sshd4pl.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /opt/logicmoo_workspace/packs_web/swish/pack/libssh/c/sshd4pl.c > CMakeFiles/sshd4pl.dir/c/sshd4pl.c.i

CMakeFiles/sshd4pl.dir/c/sshd4pl.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sshd4pl.dir/c/sshd4pl.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /opt/logicmoo_workspace/packs_web/swish/pack/libssh/c/sshd4pl.c -o CMakeFiles/sshd4pl.dir/c/sshd4pl.c.s

# Object files for target sshd4pl
sshd4pl_OBJECTS = \
"CMakeFiles/sshd4pl.dir/c/sshd4pl.c.o"

# External object files for target sshd4pl
sshd4pl_EXTERNAL_OBJECTS =

sshd4pl.so: CMakeFiles/sshd4pl.dir/c/sshd4pl.c.o
sshd4pl.so: CMakeFiles/sshd4pl.dir/build.make
sshd4pl.so: /usr/lib/x86_64-linux-gnu/libssh.so
sshd4pl.so: /opt/logicmoo_workspace/lib/swipl/lib/x86_64-linux/libswipl.so
sshd4pl.so: /usr/lib/x86_64-linux-gnu/libutil.so
sshd4pl.so: CMakeFiles/sshd4pl.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/opt/logicmoo_workspace/packs_web/swish/pack/libssh/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C shared module sshd4pl.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sshd4pl.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/sshd4pl.dir/build: sshd4pl.so

.PHONY : CMakeFiles/sshd4pl.dir/build

CMakeFiles/sshd4pl.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/sshd4pl.dir/cmake_clean.cmake
.PHONY : CMakeFiles/sshd4pl.dir/clean

CMakeFiles/sshd4pl.dir/depend:
	cd /opt/logicmoo_workspace/packs_web/swish/pack/libssh/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/logicmoo_workspace/packs_web/swish/pack/libssh /opt/logicmoo_workspace/packs_web/swish/pack/libssh /opt/logicmoo_workspace/packs_web/swish/pack/libssh/build /opt/logicmoo_workspace/packs_web/swish/pack/libssh/build /opt/logicmoo_workspace/packs_web/swish/pack/libssh/build/CMakeFiles/sshd4pl.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/sshd4pl.dir/depend

