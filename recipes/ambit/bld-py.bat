
cmake %CMAKE_ARGS% ^
  -G "Ninja" ^
  -S "%SRC_DIR%\\pyambit" ^
  -B build_py ^
  -D CMAKE_BUILD_TYPE=Release ^
  -D CMAKE_INSTALL_PREFIX="%PREFIX%" ^
  -D CMAKE_C_COMPILER=clang-cl ^
  -D CMAKE_C_FLAGS="/EHsc %CFLAGS%" ^
  -D CMAKE_CXX_COMPILER=clang-cl ^
  -D CMAKE_CXX_FLAGS="/EHsc -Xclang -fopenmp %CXXFLAGS%" ^
  -D CMAKE_INSTALL_LIBDIR="Library\lib" ^
  -D CMAKE_INSTALL_INCLUDEDIR="Library\include" ^
  -D CMAKE_INSTALL_BINDIR="Library\bin" ^
  -D CMAKE_INSTALL_DATADIR="Library\share" ^
  -D PYMOD_INSTALL_LIBDIR="/../../Lib/site-packages" ^
  -D ambit_INSTALL_CMAKEDIR="Library\share\cmake\ambit" ^
  -D ambit_ENABLE_PYTHON=ON ^
  -D Python_EXECUTABLE="%PYTHON%" ^
  -D CMAKE_VERBOSE_MAKEFILE=OFF ^
  -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"
if errorlevel 1 exit 1

cmake --build build_py ^
      --config Release ^
      --target install ^
      -- -j %CPU_COUNT%
if errorlevel 1 exit 1

dir %SP_DIR%\\ambit

REM pytest in conda testing stage
