{ stdenv
, lib
, fetchFromGitHub
, testers
, doxygen
, qmake
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "qdjango";
  version = "unstable-2018-03-07";

  src = fetchFromGitHub {
    owner = "jlaine";
    repo = "qdjango";
    rev = "bda4755ece9d173a67b880e498027fcdc51598a8";
    hash = "sha256-5MfRfsIlv73VMvKMBCLviXFovyGH0On5ukLIEy7zwkk=";
  };

  outputs = [ "out" "dev" "doc" ];

  postPatch = ''
    # HTML docs depend on regular docs
    substituteInPlace qdjango.pro \
      --replace 'dist.depends = docs' 'htmldocs.depends = docs'
  '' + lib.optionalString stdenv.hostPlatform.isDarwin ''
    # tst_Auth:constIterator (tests/db/auth/tst_auth.cpp:624) fails on Darwin?
    # QVERIFY(&*(it += 2) == 0) evals to false
    substituteInPlace tests/db/db.pro \
      --replace 'auth' ""
  '';

  qmakeFlags = [
    # Uses Qt testing infrastructure via QMake CONFIG testcase,
    # defaults to installing all testcase targets under Qt prefix
    # https://github.com/qt/qtbase/blob/29400a683f96867133b28299c0d0bd6bcf40df35/mkspecs/features/testcase.prf#L110-L120
    "CONFIG+=no_testcase_installs"

    # Qmake-generated pkg-config files default to Qt prefix
    "QMAKE_PKGCONFIG_PREFIX=${placeholder "out"}"
  ];

  nativeBuildInputs = [
    doxygen
    qmake
  ];

  dontWrapQtApps = true;

  doCheck = stdenv.buildPlatform.canExecute stdenv.hostPlatform;

  preCheck = lib.optionalString stdenv.hostPlatform.isDarwin ''
    # at this point in the build, install_name for dylibs hasn't been patched yet so we need to set the library path.
    # for some reason, this doesn't work when just exporting the needed paths even though the autogenerated wrappers
    # should at most prepend paths? just patch them into the wrappers instead
    substituteInPlace $(find tests -name target_wrapper.sh) \
      --replace 'DYLD_LIBRARY_PATH=' "DYLD_LIBRARY_PATH=$PWD/src/db:$PWD/src/http:"
  '';

  passthru.tests.pkg-config = testers.testMetaPkgConfig finalAttrs.finalPackage;

  meta = with lib; {
    description = "Qt-based C++ web framework";
    homepage = "https://github.com/jlaine/qdjango";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ OPNA2608 ];
    platforms = platforms.all;
    pkgConfigModules = [
      "qdjango-db"
      "qdjango-http"
    ];
  };
})