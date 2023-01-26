# gvox-odin

This repo contains Odin bindings for the [gvox library](https://github.com/GabeRundlett/gvox).  
Please note that this bindings are currently untested and hand-made (so I might need some time to keep the repo synched
with the mainstream gvox library).  
Note that this is for windows ONLY (for now).

# TODO: Setting up the bindings
*Note: This instructions are not functional yet. They describe only how the bindings will be used in the future.*
## Requirements
Since the gvox library is built from source, you must have the following things installed to build the repository:
- A `C++` compiler
- `CMake` (3.21 or higher)
- `Ninja build`
- `vcpkg` (plus the VCPKG_ROOT environment variable)

## Setup
If you are using git, add the bindings as a submodule to your libraries/shared folder using the following commands:
```
git submodule add https://github.com/BlackHole00/gvox-odin.git your/libraries/folder/gvox
git submodule update --init --recursive
```
If you are not using git simply clone the repository in your libraries/shared folder using the following command:
```
git clone --recursive https://github.com/BlackHole00/gvox-odin your/libraries/folder/gvox
```
Then, to build the gvox library, use the following commands:
```cmd
cd your\libraries\folder\gvox
prepare_gvox.bat
```
If everything has been done correctly you should be able include the bindings in your odin codebase using `import "shared:gvox"` and build it without getting any linker errors.