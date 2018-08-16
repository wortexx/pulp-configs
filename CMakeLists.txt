cmake_minimum_required(VERSION 3.5)
set(CMAKE_C_COMPILER_WORKS YES)

option(StandaloneApp "Install as standalone app" OFF)
option(InstallTools "Install the config tools" ON)

# cmake's phython find module seems very buggy. This is quick and easy.
execute_process(COMMAND python3.6 "--version"
    RESULT_VARIABLE _RETVAL
    OUTPUT_VARIABLE _VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
if (NOT(_RETVAL EQUAL 0) OR _VERSION VERSION_LESS PYTHON_MINIMAL_VERSION_REQUIRED)
    message(FATAL_ERROR "Python 3.6 not found in path")
endif()

set(CONFIGS_DIR "configs")
set(CONFIGS_SRC_DIR "${CMAKE_CURRENT_BINARY_DIR}/${CONFIGS_DIR}")
set(CONFIGS_DST_DIR "${CMAKE_CURRENT_BINARY_DIR}/${CONFIGS_DIR}")
set(USECASES_DIR "usecases")
set(CHIPS_DIR chips)
set(SYSTEMS_DIR "systems")
set(TEMPLATES_DIR "templates")

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/configs DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

SET(PYTHON_PATH $ENV{PYTHONPATH})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake")

include(FindPythonModule)
find_python_module(json_tools)

if (PY_JSON_TOOLS)
    message(STATUS "Using installed Json-tools")
else()
    message(STATUS "Adding Json-tools install step")
    include(ExternalProject)

    set(EXTERNAL_INSTALL_LOCATION ${CMAKE_BINARY_DIR}/external)

    # Add in JSON-TOOLS
    ExternalProject_Add(
        json-tools
        PREFIX ${CMAKE_BINARY_DIR}/json-tools
        GIT_REPOSITORY https://github.com/GreenWaves-Technologies/json-tools
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/json-tools
        LOG_DOWNLOAD ON
    )

    ExternalProject_Get_Property(json-tools install_dir)
    SET(PYTHON_PATH "${install_dir}/python:${PYTHON_PATH}")
endif()

add_custom_target(gen)

macro(build_something TARGET SCRIPT OUTPUT EXTRA_DEPENDS)
    add_custom_command(OUTPUT ${OUTPUT}
        COMMAND ${CMAKE_COMMAND} -E env "PYTHONPATH=${PYTHON_PATH}" "PATH=${CMAKE_CURRENT_SOURCE_DIR}/bin:$ENV{PATH}" "PULP_CONFIGS_PATH=${CONFIGS_SRC_DIR}" python3.6 "${CMAKE_CURRENT_SOURCE_DIR}/bin/${SCRIPT}" --configs=${CONFIGS_SRC_DIR} --output=${CONFIGS_DST_DIR}/${OUTPUT} ${ARGN}
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/bin/${SCRIPT} ${EXTRA_DEPENDS}
        VERBATIM
    )
    add_custom_target(gen.${TARGET} DEPENDS ${OUTPUT})
    if(NOT PY_JSON_TOOLS)
        add_dependencies(gen.${TARGET} json-tools)
    endif()
    add_dependencies(gen gen.${TARGET})
endmacro()

macro(build_usecase USECASE )
    set(USECASE "${USECASES_DIR}/${USECASE}.json")
    build_something(${USECASE} pulp_usecase_gen "${USECASE}" "" ${ARGN})
endmacro()

macro(build_config SYSTEM USECASE)
    set(SYSTEM_OUTPUT "${SYSTEMS_DIR}/${SYSTEM}.json")
    set(USECASE_FILE "${USECASES_DIR}/${USECASE}.json")
    build_something(${SYSTEM} pulp_config_gen "${SYSTEM_OUTPUT}" "${USECASE}" "--output-dir=${CONFIGS_SRC_DIR}/${CHIPS_DIR}" "--template=${TEMPLATES_DIR}/${CHIPS_DIR}/${SYSTEM}.json" "--usecase=${USECASE_FILE}" )
endmacro()

macro(build_top SYSTEM)
    set(SYSTEM_OUTPUT "${SYSTEMS_DIR}/${SYSTEM}.json")
    build_something(${SYSTEM} pulp_top_gen "${SYSTEM_OUTPUT}" "" "--system=${SYSTEM}")
endmacro()

build_usecase("jtag-cam" "--cam")
build_usecase("jtag" "")
build_config("pulp" "jtag-cam")
build_config("multino" "jtag")
build_config("pulpissimo" "jtag-cam")
build_config("arnold" "jtag-cam")
build_config("pulpissimo-zeroriscy" "jtag-cam")
build_config("pulpissimo-microriscy" "jtag-cam")
build_config("pulpissimo-riscy" "jtag-cam")
build_config("wolfe" "jtag-cam")
# build_config("oprecompkw" "jtag")
# build_config("oprecompkw_sfloat_sa" "jtag")
# build_config("oprecompkw_sa" "jtag")
# build_config("oprecompkw-dram")
build_config("vega" "jtag-cam")
build_config("gap" "jtag-cam")
build_top("vivosoc3")
build_config("bigpulp-z-7045" "jtag")
build_config("bigpulp" "jtag")
build_top("fulmine")
# build_config("hero-z-7045")
build_top("honey")
build_top("neuraghe")
build_top("quentin")
build_top("vivosoc2_1")
build_top("vivosoc2")

message(STATUS ${FILE_TARGETS})

foreach(file_target ${FILE_TARGETS})
    add_dependencies(pulp-configs ${file_target})
endforeach()

if(StandaloneApp)
  set(DEST_BIN ".")
  set(DEST_CONFIGS "configs")
  set(DEST_LIBS ".")
  set(DEST_MODULES ".")
else()
  set(DEST_BIN "bin")
  set(DEST_CONFIGS "configs")
  set(DEST_LIBS "lib")
  set(DEST_MODULES "python")
endif()

install(
  DIRECTORY ${CONFIGS_DST_DIR}/ DESTINATION ${DEST_CONFIGS}
  FILES_MATCHING PATTERN "*.json"
)

if (InstallTools)
    install(
        DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/ DESTINATION ${DEST_BIN}
        FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
        FILES_MATCHING PATTERN "*.py" PATTERN "pulp_*" PATTERN "__pycache__" EXCLUDE
    )
endif()