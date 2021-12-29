# A Native Mod Loader
[![Build](https://github.com/Ewpratten/animal-loader/actions/workflows/build.yml/badge.svg)](https://github.com/Ewpratten/animal-loader/actions/workflows/build.yml)
[![Clippy](https://github.com/Ewpratten/animal-loader/actions/workflows/clippy.yml/badge.svg)](https://github.com/Ewpratten/animal-loader/actions/workflows/clippy.yml)


`animal-loader` (A not-so-acronym for "A Native Mod Loader") is an experimental, unfinished project to allow the @kleientertainment games [Don't Starve](https://www.klei.com/games/dont-starve) and [Don't Starve Together](https://www.klei.com/games/dont-starve-together) to load native mods written in rust, and support WebAssembly plugins.

I started this project with very little knowledge of how LUA handles FFI, and quickly learned my way around the system, then was immediately hit with the roadblock of Klei disabling dynamic library loading in their game (which requires a re-compile to enable). So, I decided to just leave this project as-is in case it benefits someone else, or I need some of the code here later.

## How it works

At runtime, the game loads this `animal-loader` like any other mod. The mod's LUA script then modifies the interpreter's `package.cpath` to include Facebook's [`luaffifb`](https://github.com/facebookarchive/luaffifb) as a C module. This C module then loads `animal-loader`'s main Rust source code via `LUA <--> Rust` FFI.

The goal was to have the Rust code then perform its own mod-loading step, and pull in WASM modules containing other mods, but I never managed to get to this step.

## Installation

Make sure you have Rust's `cargo` and LUA's `luarocks` installed, then:

```sh
# Build the mod to ./build
make

# Copy the mod files into the game's mods folder (Linux)
cp -r ./build ~/.local/share/Steam/steamapps/common/Don\'t\ Starve\ Together/mods/animal_loader
```

Then launch the game, and enable the mod.
