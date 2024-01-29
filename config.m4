PHP_ARG_ENABLE([couchbase],
               [whether to enable Couchbase support],
               [AS_HELP_STRING([--enable-couchbase],
                               [Enable Couchbase support])])

AC_SUBST(PHP_COUCHBASE)

if test "$PHP_COUCHBASE" != "no"; then
  PHP_REQUIRE_CXX

  # PHP_REQUIRE_CXX macro might incorrectly format CXX variable,
  # concatenating standard selection flags directly to the path,
  # instead of using CXXFLAGS. Let's try to fix this issue.
  AC_CHECK_FILE([$CXX], [CXX_PATH=$CXX], [CXX_PATH=no])
  if test "$CXX_PATH" = "no"; then
    AC_MSG_NOTICE([PHP suggested C++ compiler, which includes flags "$CXX", trying to strip them])
    # Remove extra flags (considering flags are separated by spaces)
    CXX_PATH=$(echo "$CXX" | cut -d' ' -f1)
    AC_CHECK_FILE([$CXX_PATH], [], [CXX_PATH=no])
    # If a valid path is found, update CXX
    if test "$CXX_PATH" == "no"; then
      AC_MSG_NOTICE([Unable to locate path to C++ compiler, falling back to "c++"])
      AC_SUBST([CXX_PATH], [c++])
    fi
  fi
  AC_MSG_NOTICE([Detected C++ compiler: $CXX_PATH])

  AC_PATH_PROG(CMAKE, cmake, no)
  if ! test -x "${CMAKE}"; then
    AC_MSG_ERROR(Please install cmake to build couchbase extension)
  fi

  CXX="${CXX_PATH}"
  CXXFLAGS="${CXXFLAGS} -std=c++17"
  COUCHBASE_CMAKE_SOURCE_DIRECTORY="$srcdir/src"
  COUCHBASE_CMAKE_BUILD_DIRECTORY="$ac_pwd/cmake-build"

  PHP_SUBST([CMAKE])
  PHP_SUBST([COUCHBASE_CMAKE_SOURCE_DIRECTORY])
  PHP_SUBST([COUCHBASE_CMAKE_BUILD_DIRECTORY])

  PHP_ADD_LIBRARY_DEFER_WITH_PATH(couchbase_php_wrapper, $EXTENSION_DIR, COUCHBASE_SHARED_LIBADD)
  PHP_ADD_LIBRARY_DEFER_WITH_PATH(couchbase_php_wrapper, "$ac_pwd/modules", COUCHBASE_SHARED_LIBADD)

  PHP_SUBST([COUCHBASE_SHARED_LIBADD])
  COUCHBASE_SHARED_DEPENDENCIES="\$(phplibdir)/libcouchbase_php_wrapper.${SHLIB_SUFFIX_NAME}"
  PHP_SUBST([COUCHBASE_SHARED_DEPENDENCIES])

  COUCHBASE_FILES="src/php_couchbase.cxx"

  PHP_NEW_EXTENSION(couchbase, ${COUCHBASE_FILES}, $ext_shared,,, cxx)
  PHP_ADD_EXTENSION_DEP(couchbase, json)
  PHP_ADD_BUILD_DIR($ext_builddir/src, 1)
fi

PHP_ADD_MAKEFILE_FRAGMENT

AC_CONFIG_COMMANDS_POST([
  echo "
CMAKE                  : ${CMAKE}
CMAKE_BUILD_TYPE       : ${COUCHBASE_CMAKE_BUILD_TYPE:-Release}
CMAKE_SOURCE_DIRECTORY : ${COUCHBASE_CMAKE_SOURCE_DIRECTORY}
CMAKE_BUILD_DIRECTORY  : ${COUCHBASE_CMAKE_BUILD_DIRECTORY}
CMAKE_C_COMPILER       : ${CC}
CMAKE_CXX_COMPILER     : ${CXX}
CMAKE_C_FLAGS          : ${CFLAGS}
CMAKE_CXX_FLAGS        : ${CXXFLAGS}
COUCHBASE_PHP_INCLUDES : ${INCLUDES}
COUCHBASE_PHP_LDFLAGS  : ${LDFLAGS}
COUCHBASE_PHP_LIBDIR   : ${phplibdir}
COUCHBASE_CMAKE_EXTRA  : ${COUCHBASE_CMAKE_EXTRA}
"
  ${CMAKE} -S ${COUCHBASE_CMAKE_SOURCE_DIRECTORY} -B${COUCHBASE_CMAKE_BUILD_DIRECTORY} \
         -DCMAKE_BUILD_TYPE=${COUCHBASE_CMAKE_BUILD_TYPE:-RelWithDebInfo} \
         -DCMAKE_C_COMPILER="${CC}" \
         -DCMAKE_CXX_COMPILER="${CXX}" \
         -DCMAKE_C_FLAGS="${CFLAGS}" \
         -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
         -DCOUCHBASE_PHP_INCLUDES="${INCLUDES}" \
         -DCOUCHBASE_PHP_LDFLAGS="${LDFLAGS}" \
         -DCOUCHBASE_PHP_LIBDIR="${phplibdir}" \
         -DCOUCHBASE_CXX_CLIENT_BUILD_DOCS=OFF \
         -DCOUCHBASE_CXX_CLIENT_BUILD_EXAMPLES=OFF \
         -DCOUCHBASE_CXX_CLIENT_BUILD_TOOLS=OFF \
         -DCOUCHBASE_CXX_CLIENT_BUILD_TESTS=OFF ${COUCHBASE_CMAKE_EXTRA}
])
