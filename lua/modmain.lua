-- Since we are messing around with the game's LUA interpreter at runtime
-- we should dump some debug info before anything has the chance to go horribly wrong
package = require("package")
print("[ANIMAL] (Preload) Lua Path: " .. package.path)
print("[ANIMAL] (Preload) Lua C Path: " .. package.cpath)

-- We want the ability to inject our own LUA modules into the CPATH, so we shall update it
package.cpath = "../mods/animal_loader/lua_modules/?.so;" .. package.cpath
print("[ANIMAL] (Preload) Modified Lua C Path: " .. package.cpath)

-- No we can finally load Facebook's FFI library
-- This should be a drop-in replacement for the one in LuaJIT
print("[ANIMAL] (Preload) Loading alternative FFI library")
ffi = require("ffi")
ffi.cdef [[
void on_load();
]]

-- Load the Rust side of this mod
rust_lib = ffi.load("./libanimal.so")

-- Call into the Rust library to let it do whatever it needs as soon as this plugin is loaded
print("Calling Rust on_load()")
rust_lib.on_load()

-- AddGamePostInit(gamepostinit)
