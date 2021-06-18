cmake_minimum_required(VERSION 3.1.0)

project(libpointmatcher VERSION 1.3.1)

find_package(Boost COMPONENTS thread filesystem system program_options date_time chrono REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(libnabo REQUIRED)

# Pointmatcher lib and install
set(POINTMATCHER_SRC
	pointmatcher/Logger.cpp
	pointmatcher/Exceptions.cpp
	pointmatcher/DataPoints.cpp
	pointmatcher/Matches.cpp
	pointmatcher/ICP.cpp
	pointmatcher/Registry.cpp
	pointmatcher/Registrar.cpp
	pointmatcher/DataPointsFilter.cpp
	pointmatcher/Matcher.cpp
	pointmatcher/OutlierFilter.cpp
	pointmatcher/ErrorMinimizer.cpp
	pointmatcher/Transformation.cpp
	pointmatcher/TransformationChecker.cpp
	pointmatcher/Inspector.cpp
	pointmatcher/IO.cpp
	pointmatcher/IOFunctions.cpp
	pointmatcher/Bibliography.cpp
	pointmatcher/Timer.cpp
	pointmatcher/Histogram.cpp
	pointmatcher/Parametrizable.cpp
	pointmatcher/LoggerImpl.cpp
	pointmatcher/MatchersImpl.cpp
	pointmatcher/OutlierFiltersImpl.cpp
	pointmatcher/TransformationsImpl.cpp
	pointmatcher/TransformationCheckersImpl.cpp
	pointmatcher/InspectorsImpl.cpp
#ErrorMinimizers
	pointmatcher/ErrorMinimizers/PointToPlane.cpp
	pointmatcher/ErrorMinimizers/PointToPlaneWithCov.cpp
	pointmatcher/ErrorMinimizers/PointToPoint.cpp
	pointmatcher/ErrorMinimizers/PointToPointWithCov.cpp
	pointmatcher/ErrorMinimizers/PointToPointSimilarity.cpp
	pointmatcher/ErrorMinimizers/Identity.cpp
#DataPointsFilters
	pointmatcher/DataPointsFilters/Identity.cpp
	pointmatcher/DataPointsFilters/RemoveNaN.cpp
	pointmatcher/DataPointsFilters/MaxDist.cpp
	pointmatcher/DataPointsFilters/MinDist.cpp
	pointmatcher/DataPointsFilters/BoundingBox.cpp
	pointmatcher/DataPointsFilters/MaxQuantileOnAxis.cpp
	pointmatcher/DataPointsFilters/MaxDensity.cpp
	pointmatcher/DataPointsFilters/SurfaceNormal.cpp
	pointmatcher/DataPointsFilters/SamplingSurfaceNormal.cpp
	pointmatcher/DataPointsFilters/OrientNormals.cpp
	pointmatcher/DataPointsFilters/IncidenceAngle.cpp
	pointmatcher/DataPointsFilters/RandomSampling.cpp
	pointmatcher/DataPointsFilters/MaxPointCount.cpp
	pointmatcher/DataPointsFilters/FixStepSampling.cpp
	pointmatcher/DataPointsFilters/Shadow.cpp
	pointmatcher/DataPointsFilters/SimpleSensorNoise.cpp
	pointmatcher/DataPointsFilters/ObservationDirection.cpp
	pointmatcher/DataPointsFilters/VoxelGrid.cpp
	pointmatcher/DataPointsFilters/CutAtDescriptorThreshold.cpp
	pointmatcher/DataPointsFilters/Elipsoids.cpp
	pointmatcher/DataPointsFilters/Gestalt.cpp
	pointmatcher/DataPointsFilters/OctreeGrid.cpp
	pointmatcher/DataPointsFilters/NormalSpace.cpp
	pointmatcher/DataPointsFilters/CovarianceSampling.cpp
	pointmatcher/DataPointsFilters/DistanceLimit.cpp
	pointmatcher/DataPointsFilters/RemoveSensorBias.cpp
	pointmatcher/DataPointsFilters/Sphericality.cpp
	pointmatcher/DataPointsFilters/Saliency.cpp	
	pointmatcher/DataPointsFilters/SpectralDecomposition.cpp	
)


file(GLOB_RECURSE POINTMATCHER_HEADERS "pointmatcher/*.h")

add_library(${PROJECT_NAME} ${POINTMATCHER_SRC} ${POINTMATCHER_HEADERS} )

target_include_directories(${PROJECT_NAME}
	PUBLIC
		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/pointmatcher>
		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/contrib/yaml-cpp-pm/include>
		$<INSTALL_INTERFACE:include>
)

target_link_libraries(${PROJECT_NAME}
	PUBLIC
		Boost::thread
		Boost::filesystem
		Boost::system
		Boost::program_options
		Boost::date_time
		Boost::chrono
		Eigen3::Eigen
		libnabo::nabo
)

install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}-targets
	ARCHIVE DESTINATION lib
	LIBRARY DESTINATION lib
	RUNTIME DESTINATION bin
)

install(FILES package.xml DESTINATION "share/${PROJECT_NAME}")

install(
	FILES
		pointmatcher/DeprecationWarnings.h
		pointmatcher/PointMatcher.h
		pointmatcher/PointMatcherPrivate.h
		pointmatcher/Parametrizable.h
		pointmatcher/Registrar.h
		pointmatcher/Timer.h
		pointmatcher/Functions.h
		pointmatcher/IO.h
	DESTINATION include/pointmatcher
)

# Export the library interface
install(EXPORT ${PROJECT_NAME}-targets
	NAMESPACE ${PROJECT_NAME}::
	DESTINATION lib/cmake/${PROJECT_NAME}
)

# Add alias target to use pointmatcher from build space
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# Create and install the version file
include(CMakePackageConfigHelpers)
write_basic_package_version_file("${PROJECT_NAME}-config-version.cmake"
	VERSION ${POINTMATCHER_VERSION}
	COMPATIBILITY SameMajorVersion
)

install(
	FILES
		${PROJECT_NAME}-config.cmake
		${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
	DESTINATION
		lib/cmake/${PROJECT_NAME}
)
