{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          althttpd = pkgs.callPackage ./packages/althttpd.nix { };
        };

        devShell = with pkgs; pkgs.mkShell {
          buildInputs = [
            tcl
            gcc
            wabt
            emscripten
            unzip
            # althttpd
            self.packages.${system}.althttpd # need newer version with `--enable-sab` flag
          ];

          shellHook = ''
            cp -r ${pkgs.emscripten}/share/emscripten/cache/ /tmp/emscripten_cache_sqlite
            chmod u+rwX -R /tmp/emscripten_cache_sqlite
            export EM_CACHE=/tmp/emscripten_cache_sqlite
          '';

        };


      });
}
