# gvox-odin

This repo contains Odin bindings for the [gvox library](https://github.com/GabeRundlett/gvox).  
Please note that this bindings are currently untested and hand-made (so I might need some time to keep the repo synched 
with the mainstream gvox library).

## Notes on the .lib file
In Windows, in order to compile a library that have to be compatible with Odin it is needed to build it using the `/MT` 
switch (in VS2022 it is under `C/C++`->`Code Generation`->`Runtime Library`).
