package gvox

import "core:c"

when ODIN_OS == .Windows do foreign import gvox "gvox.lib"
// else when ODIN_OS == .Linux do foreign import gvox "gvox.a"
// else when ODIN_OS == .Darwin do foreign import gvox "gvox.a"
else do #panic("Not yet supported. Use Windows or provide your own gvox library file.")

Result :: enum {
    SUCCESS                     =  0,
    ERROR_FAILED_TO_LOAD_FILE   = -1,
    ERROR_FAILED_TO_LOAD_FORMAT = -2,
    ERROR_INVALID_FORMAT        = -3,
}

Voxel :: struct {
    color: [3]f32,
    id: u32,
}

SceneNode :: struct {
    size_x, size_y, size_z: u64,
    voxels: [^]Voxel,
}

Scene :: struct {
    node_n: u64,
    nodes: [^]SceneNode,
}

Header :: struct {
    format_name_size: u64,
    payload_size: u64,
}

Payload :: struct {
    size: u64,
    data: [^]byte,
}

FormatLoaderInfo :: struct {
    name_str:           cstring,

    create_context:     proc() -> rawptr,
    destroy_context:    proc(rawptr),
    create_payload:     proc(rawptr, ^Scene) -> Payload,
    destroy_payload:    proc(rawptr, ^Payload),
    parse_payload:      proc(rawptr, ^Payload) -> Scene,
}

Context :: struct {}

@(default_calling_convention="c", link_prefix="gvox_")
foreign gvox {
    create_context      :: proc() -> ^Context ---
    destroy_context     :: proc(ctx: ^Context) ---

    when #config("GVOX_ENABLE_FILE_IO", true) {
        load_header     :: proc(filepath: cstring) -> c.size_t ---

        push_root_path  :: proc(ctx: ^Context, path: cstring) ---
        pop_root_path   :: proc(ctx: ^Context) ---

        load            :: proc(ctx: ^Context, filepath: cstring) -> Scene ---
        load_from_raw   :: proc(ctx: ^Context, filepath: cstring, src_format: cstring) -> Scene ---
        save            :: proc(ctx: ^Context, scene: ^Scene, filepath: cstring, src_format: cstring) ---
        save_as_raw     :: proc(ctx: ^Context, scene: ^Scene, filepath: cstring, src_format: cstring) ---
    }

    register_format     :: proc(ctx: ^Context, format_loader_info: ^FormatLoaderInfo) ---
    load_format         :: proc(ctx: ^Context, format_loader_name: cstring) ---

    get_result          :: proc(ctx: ^Context) -> Result ---
    get_result_message  :: proc(ctx: ^Context, str_buffer: [^]byte, str_size: ^c.size_t) ---
    pop_result          :: proc(ctx: ^Context) ---

    parse               :: proc(ctx: ^Context, payload: ^Payload, src_format: cstring) -> Scene ---
    serialize           :: proc(ctx: ^Context, scene: ^Scene, dst_format: cstring) -> Payload ---
    load_raw_payload_into :: proc(ctx: ^Context, scene: ^Scene, dst_format: cstring, dst_ptr: [^]u8) ---
    serialize_into      :: proc(ctx: ^Context, scene: ^Scene, dst_format: cstring, dst_ptr: [^]u8) ---

    destroy_payload     :: proc(ctx: ^Context, payload: ^Payload, format: cstring) ---
    destroy_scene       :: proc(scene: ^Scene) ---
}
