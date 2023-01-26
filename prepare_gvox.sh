if ! command -v cmake &> /dev/null
then
    echo "cmake could not be found"
    exit
fi

cd _gvox_source

cmake -D GVOX_BUILD_FOR_ODIN=1 .
cmake --build . --config Release

cd ..

mv _gvox_source/libgvox.a ./libgvox.a