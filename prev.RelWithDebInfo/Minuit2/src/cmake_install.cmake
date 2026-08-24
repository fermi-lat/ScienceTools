# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/jamrhein/miniforge3/envs/fermi-0819master")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/opt/homebrew/opt/llvm/bin/llvm-objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Minuit2/src/libFermiMinuit2.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libFermiMinuit2.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libFermiMinuit2.a")
    execute_process(COMMAND "/opt/homebrew/opt/llvm/bin/llvm-ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libFermiMinuit2.a")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/fermi/Minuit2/Minuit2" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ABObj.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ABProd.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ABSum.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ABTypes.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/AnalyticalGradientCalculator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/BFGSErrorUpdator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/BasicFunctionGradient.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/BasicFunctionMinimum.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/BasicMinimumError.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/BasicMinimumParameters.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/BasicMinimumSeed.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/BasicMinimumState.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/CombinedMinimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/CombinedMinimumBuilder.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ContoursError.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/DavidonErrorUpdator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FCNAdapter.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FCNBase.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FCNGradAdapter.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FCNGradientBase.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliBuilder.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliChi2FCN.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliErrorUpdator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliFCNAdapter.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliFCNBase.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliGradientCalculator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliMaximumLikelihoodFCN.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliMinimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliStandardChi2FCN.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FumiliStandardMaximumLikelihoodFCN.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FunctionGradient.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FunctionMinimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/FunctionMinimum.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/GenericFunction.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/GradientCalculator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/HessianGradientCalculator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/InitialGradientCalculator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/LASymMatrix.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/LAVector.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/LaInverse.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/LaOuterProduct.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/LaProd.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/LaSum.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MPIProcess.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MatrixInverse.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinimumBuilder.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinimumError.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinimumErrorUpdator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinimumParameters.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinimumSeed.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinimumSeedGenerator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinimumState.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinosError.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/Minuit2Minimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MinuitParameter.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnApplication.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnConfig.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnContours.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnCovarianceSqueeze.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnCross.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnEigen.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnFcn.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnFumiliMinimize.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnFunctionCross.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnGlobalCorrelationCoeff.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnHesse.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnLineSearch.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnMachinePrecision.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnMatrix.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnMigrad.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnMinimize.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnMinos.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnParabola.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnParabolaFactory.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnParabolaPoint.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnParameterScan.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnPlot.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnPosDef.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnPrint.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnRefCountedPointer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnReferenceCounter.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnScan.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnSeedGenerator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnSimplex.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnStrategy.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnTiny.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnTraceObject.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnUserCovariance.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnUserFcn.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnUserParameterState.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnUserParameters.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnUserTransformation.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/MnVectorTransform.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ModularFunctionMinimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/NegativeG2LineSearch.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/Numerical2PGradientCalculator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ParametricFunction.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ScanBuilder.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/ScanMinimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/SimplexBuilder.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/SimplexMinimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/SimplexParameters.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/SimplexSeedGenerator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/SinParameterTransformation.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/SqrtLowParameterTransformation.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/SqrtUpParameterTransformation.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/StackAllocator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/VariableMetricBuilder.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/VariableMetricEDMEstimator.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/VariableMetricMinimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Minuit2/VectorOuterProduct.h"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Minuit2/src/math/cmake_install.cmake")

endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Minuit2/src/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
