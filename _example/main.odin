package main

import "../gvox"

main :: proc() {
    gvox_ctx := gvox.create_context()
    defer gvox.destroy_context(gvox_ctx)

    if gvox.get_result(gvox_ctx) != .SUCCESS do panic("Gvox not successfully initialized!")

    // TODO!
}