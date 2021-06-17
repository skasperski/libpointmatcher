cmake_minimum_required(VERSION 3.1.0)

project(libpointmatcher VERSION 1.0.0)

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

add_library(pointmatcher ${POINTMATCHER_SRC} ${POINTMATCHER_HEADERS} )

target_include_directories(pointmatcher
	PUBLIC
		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>/pointmatcher
		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>/contrib/yaml-cpp-pm/include
		$<INSTALL_INTERFACE:include>
)

target_link_libraries(pointmatcher
	PUBLIC
		Boost::thread
		Boost::filesystem
		Boost::system program_options
		Boost::date_time
		Boost::chrono
		Eigen3::Eigen
		libnabo::nabo
	PRIVATE
		${libnabo_LIBRARIES}
)

install(TARGETS pointmatcher EXPORT ${PROJECT_NAME}-targets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

install(FILES package.xml DESTINATION "share/${PROJECT_NAME}")

