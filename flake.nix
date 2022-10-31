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
            cp -r /nix/store/${pkgs.emscripten}/share/emscripten/cache/ ~/.emscripten_cache
            chmod u+rwX -R ~/.emscripten_cache
            export EM_CACHE=~/.emscripten_cache
          '';

        };


      });
}
