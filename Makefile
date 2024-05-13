# The directory where PHP-CPP will be cloned into
# PHP-CPP is a library for developing PHP extensions using C++
PHP_CPP_DIR = PHP-CPP

# The PHP-CPP shared library file
# This file will be created when PHP-CPP is built
PHP_CPP_LIB = $(PHP_CPP_DIR)/libphpcpp.so

# The directory where all build files will be put
# This includes the object files and the shared library file
DIST_DIR = dist

# The name of your extension
# This is used to name the shared library file and the .ini file
NAME = examplephpextension

# The directory where the .ini file will be installed
# This is determined by the 'php-config' command
INI_DIR = $(shell php-config --ini-dir)

# The directory where the .so file will be installed
# This is determined by the 'php-config' command
EXTENSION_DIR = $(shell php-config --extension-dir)

# The name of the .so file
# This is based on the name of your extension
EXTENSION = ${NAME}.so

# The name of the .ini file
# This is based on the name of your extension
INI = ${NAME}.ini

# The compiler and linker programs
# g++ is a C++ compiler and linker
COMPILER = g++
LINKER = g++

# The flags that will be passed to the compiler and linker
# These flags tell the compiler and linker how to build the extension
COMPILER_FLAGS = -Wall -c -O2 -std=c++11 -fpic -o
LINKER_FLAGS = -shared
LINKER_DEPENDENCIES = -lphpcpp

# The commands to remove files, copy files, and create directories
# These are standard Unix commands
RM = rm -f
CP = cp -f
MKDIR = mkdir -p

# All .cpp files in the current directory
# The wildcard function finds all files that match the pattern
SOURCES = $(wildcard *.cpp)

# The object files for each .cpp file
# The addprefix function adds the 'dist/' prefix to each file
OBJECTS = $(addprefix $(DIST_DIR)/, $(SOURCES:%.cpp=%.o))

# The first rule that will be run when you type 'make'
# It depends on the PHP-CPP library, the object files, and the extension
all: $(PHP_CPP_LIB) ${OBJECTS} $(DIST_DIR)/${EXTENSION}

# Rule to build the PHP-CPP library
# It first checks if the PHP-CPP directory exists, and only clones the repo if it doesn't
# Then it goes into the PHP-CPP directory, builds the library, and installs it
$(PHP_CPP_LIB):
	if [ ! -d "$(PHP_CPP_DIR)" ]; then git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git $(PHP_CPP_DIR); fi
	cd $(PHP_CPP_DIR) && make && sudo make install

# Rule to build the extension
# It depends on the PHP-CPP library and the object files
# It links the object files into the shared library file
$(DIST_DIR)/${EXTENSION}: $(PHP_CPP_LIB) ${OBJECTS}
	${LINKER} ${LINKER_FLAGS} -o $@ ${OBJECTS} ${LINKER_DEPENDENCIES}

# Rule to build the object files
# It compiles each .cpp file into an object file
# It first checks if the 'dist' directory exists, and only creates it if it doesn't
$(DIST_DIR)/%.o: %.cpp
	if [ ! -d "$(DIST_DIR)" ]; then \
		$(MKDIR) $(DIST_DIR); \
	fi
	${COMPILER} ${COMPILER_FLAGS} $@ $<

# Rule to install the extension
# It copies the .so file and the .ini file to their respective directories
install:		
	${CP} $(DIST_DIR)/${EXTENSION} ${EXTENSION_DIR}
	${CP} ${INI} ${INI_DIR}

# Rule to clean the build
# It removes the .so file and the object files
# It also cleans the PHP-CPP library
clean:
	${RM} $(DIST_DIR)/${EXTENSION} ${OBJECTS}
	cd $(PHP_CPP_DIR) && make clean
