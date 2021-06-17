find_package(Boost COMPONENTS thread filesystem system program_options date_time chrono REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(libnabo REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/libpointmatcher-targets.cmake")
