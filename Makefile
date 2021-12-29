animal-loader: libanimal.so libffi.so
	mkdir -p build/lua_modules
	cp -r -v ./lua/* build/
	cp -v ./target/release/libanimal.so build/
	cp -v ./third_party/luaffifb/ffi.so build/lua_modules

libanimal.so:
	cargo build --release

libffi.so:
	cd third_party/luaffifb && luarocks make --local


clean: 
	rm -rf build
	cargo clean
	cd third_party/luaffifb && rm -f *.so *.o