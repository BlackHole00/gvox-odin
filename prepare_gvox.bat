@ECHO OFF

cmake.exe /?  2> NUL
IF NOT %ERRORLEVEL%==9009 (
    SET "CMAKE=cmake.exe"
) ELSE (
    ECHO WARNING: cmake is not present in system path. Using default installation path. This might fail!
    SET "CMAKE=C:\Program Files\cmake\bin\cmake.exe"
)

CD _gvox

"%CMAKE%" . -A x64 -D GVOX_BUILD_FOR_ODIN=1
"%CMAKE%" --build . --config Release

CD ..

COPY _gvox\Release\gvox.lib gvox.lib