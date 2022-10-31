# sqlite-wasm-flake

## Usage

### Deps via Nix

```sh
nix develop github:schickling-test/sqlite-wasm-flake --no-write-lock-file
```

### Build

```sh
# setup build env
./configure

# make fiddle app
make fiddle

# make sqlite-wasm dist build
make -C ext/wasm dist
```

### Try app

```sh
cd ext/wasm
althttpd --enable-sab --max-age 1 --page index.html
```
