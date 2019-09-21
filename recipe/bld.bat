set BUILD_DIR=%SRC_DIR%\bld
mkdir %BUILD_DIR%
cd %BUILD_DIR%

SET CXX_FLAGS="%CXX_FLAGS% /MP"

REM Configure Step
cmake -G "Ninja" ^
    -D BUILD_SHARED_LIBS:BOOL=ON ^
    -D BUILD_TESTING:BOOL=OFF ^
    -D BUILD_EXAMPLES:BOOL=OFF ^
    -D ITK_USE_SYSTEM_EXPAT:BOOL=OFF ^
    -D ITK_USE_SYSTEM_JPEG:BOOL=ON ^
    -D ITK_USE_SYSTEM_PNG:BOOL=ON ^
    -D ITK_USE_SYSTEM_TIFF:BOOL=ON ^
    -D ITK_USE_SYSTEM_ZLIB:BOOL=OFF ^
    -D ITK_USE_SYSTEM_FFTW:BOOL=ON ^
    -D ITK_USE_FFTWD:BOOL=ON ^
    -D ITK_USE_FFTWF:BOOL=ON ^
    -D ITK_BUILD_DEFAULT_MODULES:BOOL=ON ^
    -D Module_ITKReview:BOOL=ON ^
    -D Module_AnisotropicDiffusionLBR:BOOL=ON ^
    -D Module_FixedPointInverseDisplacementField:BOOL=ON ^
    -D Module_GenericLabelInterpolator:BOOL=ON ^
    -D Module_IsotropicWavelets:BOOL=ON ^
    -D Module_LabelErodeDilate:BOOL=ON ^
    -D Module_MinimalPathExtraction:BOOL=ON ^
    -D Module_MorphologicalContourInterpolation:BOOL=ON ^
    -D Module_MultipleImageIterator:BOOL=ON ^
    -D Module_ParabolicMorphology:BOOL=ON ^
    -D Module_PrincipalComponentsAnalysis:BOOL=ON ^
    -D Module_SimpleITKFilters:BOOL=ON ^
    -D Module_SmoothingRecursiveYvvGaussianFilter:BOOL=ON ^
    -D Module_SplitComponents:BOOL=ON ^
    -D Module_Strain:BOOL=ON ^
    -D Module_TextureFeatures:BOOL=ON ^
    -D Module_TwoProjectionRegistration:BOOL=ON ^
    -D Module_VariationalRegistration:BOOL=ON ^
    -D "CMAKE_SYSTEM_PREFIX_PATH:PATH=%LIBRARY_PREFIX%" ^
    -D "CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%" ^
    -D CMAKE_BUILD_TYPE:STRING=RELEASE ^
    "%SRC_DIR%"

if errorlevel 1 exit 1

REM Build step
cmake --build  . --config Release
if errorlevel 1 exit 1

REM Install step
cmake -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% -P %BUILD_DIR%\cmake_install.cmake
if errorlevel 1 exit 1
