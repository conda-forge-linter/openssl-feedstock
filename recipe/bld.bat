if "%ARCH%"=="32" (
    set OSSL_CONFIGURE=VC-WIN32
) ELSE (
    set OSSL_CONFIGURE=VC-WIN64A
)

REM Configure step
perl configure %OSSL_CONFIGURE% ^
    --prefix=%LIBRARY_PREFIX% ^
    --openssldir=%LIBRARY_PREFIX% ^
    shared ^
    enable-fips
if errorlevel 1 exit 1

REM specify in metadata where the packaging is coming from
set "OPENSSL_VERSION_BUILD_METADATA=+fips+conda_forge"

REM Build step
nmake
if errorlevel 1 exit 1

REM Testing step
nmake test
if errorlevel 1 exit 1
