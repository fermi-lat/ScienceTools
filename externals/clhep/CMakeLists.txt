# ########################################################################### #
# Vendored Externals: CLHEP – granular static libraries, namespaced targets   #
# ########################################################################### #

cmake_minimum_required(VERSION 3.14)
cmake_policy(SET CMP0120 NEW)
set(CMAKE_POLICY_VERSION_MINIMUM 3.10)

include(CheckFunctionExists)

message(STATUS "Local External Dependency CLHEP")
set(CLHEP_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/clhep")
set(CLHEP_BINARY_INC "${CMAKE_CURRENT_BINARY_DIR}/clhep/include")
file(MAKE_DIRECTORY "${CLHEP_BINARY_INC}/CLHEP")
set(CLHEP_VERSION 2.4.7.1)

# check for required functions
CHECK_FUNCTION_EXISTS(drand48 found_drand48)

# configures
foreach(COMPONENT IN ITEMS Units Utility Random Vector Geometry Matrix)
    set(COMPONENT_DIR "${CLHEP_SOURCE_DIR}/${COMPONENT}/${COMPONENT}")
    set(COMPONENT_DEST "${CLHEP_BINARY_INC}/CLHEP/${COMPONENT}")
    file(MAKE_DIRECTORY "${COMPONENT_DEST}")
    configure_file(${COMPONENT_DIR}/cmake-defs.h.in ${COMPONENT_DEST}/defs.h @ONLY)

    if(EXISTS "${COMPONENT_DIR}/thread_local.in")
        configure_file(${COMPONENT_DIR}/thread_local.in
                       ${COMPONENT_DEST}/thread_local.h
                       @ONLY)
    endif()

    file(GLOB COMPONENT_HEADERS "${COMPONENT_DIR}/*.h" "${COMPONENT_DIR}/*.icc")
    file(COPY ${COMPONENT_HEADERS} DESTINATION "${COMPONENT_DEST}")
endforeach()

# Units
add_library(CLHEP-Units INTERFACE) 
target_include_directories(CLHEP-Units INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)

# Utility
add_library(CLHEP-Utility INTERFACE) 
target_include_directories(CLHEP-Utility INTERFACE
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)

# Random
add_library(CLHEP-Random STATIC) 

set(CLHEP_RANDOM_SRC DoubConv.cc DRand48Engine.cc DualRand.cc EngineFactory.cc
    engineIDulong.cc erfQ.cc flatToGaussian.cc gammln.cc Hurd160Engine.cc
    Hurd288Engine.cc JamesRandom.cc MixMaxRng.cc MTwistEngine.cc NonRandomEngine.cc
    RandBinomial.cc RandBit.cc RandBreitWigner.cc RandChiSquare.cc RandEngine.cc
    RandExponential.cc RandExpZiggurat.cc RandFlat.cc RandGamma.cc RandGauss.cc
    RandGaussQ.cc RandGaussT.cc RandGaussZiggurat.cc RandGeneral.cc RandLandau.cc
    Random.cc RandomEngine.cc RandPoisson.cc RandPoissonQ.cc RandPoissonT.cc
    RandSkewNormal.cc RandStudentT.cc RanecuEngine.cc Ranlux64Engine.cc RanluxEngine.cc
    RanluxppEngine.cc RanshiEngine.cc StaticRandomStates.cc TripleRand.cc)
list(TRANSFORM CLHEP_RANDOM_SRC PREPEND "${CLHEP_SOURCE_DIR}/Random/src/")
target_sources(CLHEP-Random PRIVATE ${CLHEP_RANDOM_SRC})

target_include_directories(CLHEP-Random PRIVATE
    "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
    "$<BUILD_INTERFACE:${CLHEP_SOURCE_DIR}/Random>"
)
target_link_libraries(CLHEP-Random
    PRIVATE CLHEP-Utility CLHEP-Units Threads::Threads
)
target_link_options(CLHEP-Random PRIVATE
  "$<$<PLATFORM_ID:Darwin>:-Wl,-undefined,error>"
  "$<$<NOT:$<PLATFORM_ID:Darwin>>:-Wl,--no-undefined>"
)
target_compile_definitions(CLHEP-Random PUBLIC CLHEP_THREAD_LOCAL=thread_local)
add_library(CLHEP::Random ALIAS  CLHEP-Random)
add_library(CLHEP::RandomS ALIAS CLHEP-Random)

# Vector
add_library(CLHEP-Vector STATIC) 
set(CLHEP_VECTOR_SRC AxisAngle.cc Boost.cc BoostX.cc BoostY.cc BoostZ.cc EulerAngles.cc
    LorentzRotation.cc LorentzRotationC.cc LorentzRotationD.cc LorentzVector.cc
    LorentzVectorB.cc LorentzVectorC.cc LorentzVectorK.cc LorentzVectorL.cc
    LorentzVectorR.cc Rotation.cc RotationA.cc RotationC.cc RotationE.cc RotationIO.cc
    RotationInterfaces.cc RotationL.cc RotationP.cc RotationX.cc RotationY.cc
    RotationZ.cc SpaceVector.cc SpaceVectorD.cc SpaceVectorP.cc SpaceVectorR.cc
    ThreeVector.cc ThreeVectorR.cc TwoVector.cc ZMinput.cc ZMxpv.cc)

list(TRANSFORM CLHEP_VECTOR_SRC PREPEND "${CLHEP_SOURCE_DIR}/Vector/src/")
target_sources(CLHEP-Vector PRIVATE ${CLHEP_VECTOR_SRC})

target_include_directories(CLHEP-Vector INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Vector PUBLIC CLHEP-Units)
add_library(CLHEP::Vector ALIAS CLHEP-Vector)
add_library(CLHEP::VectorS ALIAS CLHEP-Vector)

# Geometry
add_library(CLHEP-Geometry STATIC) 
set(CLHEP_GEOMETRY_SRC "${CLHEP_SOURCE_DIR}/Geometry/src")
target_sources(CLHEP-Geometry PRIVATE
    ${CLHEP_GEOMETRY_SRC}/BasicVector3D.cc ${CLHEP_GEOMETRY_SRC}/Normal3D.cc     
    ${CLHEP_GEOMETRY_SRC}/Plane3D.cc      ${CLHEP_GEOMETRY_SRC}/Point3D.cc      
    ${CLHEP_GEOMETRY_SRC}/Transform3D.cc  ${CLHEP_GEOMETRY_SRC}/Vector3D.cc
)
target_include_directories(CLHEP-Geometry INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Geometry PUBLIC CLHEP-Vector)
add_library(CLHEP::Geometry ALIAS CLHEP-Geometry)
add_library(CLHEP::GeometryS ALIAS CLHEP-Geometry)

# Matrix
add_library(CLHEP-Matrix STATIC)
set(CLHEP_MATRIX_SRC "${CLHEP_SOURCE_DIR}/Matrix/src")
target_sources(CLHEP-Matrix PRIVATE
    ${CLHEP_MATRIX_SRC}/DiagMatrix.cc   ${CLHEP_MATRIX_SRC}/GenMatrix.cc
    ${CLHEP_MATRIX_SRC}/Matrix.cc ${CLHEP_MATRIX_SRC}/MatrixEqRotation.cc
    ${CLHEP_MATRIX_SRC}/MatrixInvert.cc ${CLHEP_MATRIX_SRC}/MatrixLinear.cc
    ${CLHEP_MATRIX_SRC}/SymMatrix.cc ${CLHEP_MATRIX_SRC}/SymMatrixInvert.cc
    ${CLHEP_MATRIX_SRC}/Vector.cc
)
target_include_directories(CLHEP-Matrix INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Matrix
    PUBLIC CLHEP::VectorS CLHEP::RandomS Threads::Threads
)
target_compile_definitions(CLHEP-Matrix PUBLIC 
    DISABLE_ALLOC
    CLHEP_THREAD_LOCAL=thread_local
)
add_library(CLHEP::Matrix ALIAS CLHEP-Matrix)
add_library(CLHEP::MatrixS ALIAS CLHEP-Matrix)

