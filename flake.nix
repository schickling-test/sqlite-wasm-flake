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

        # packages.default = pkgs.cowsay;

        devShell = with pkgs; pkgs.mkShell {
          buildInputs = [
            tcl
            gcc
            wabt
            emscripten
            unzip
            althttpd
          ];

          shellHook = ''
            cp -r ${pkgs.emscripten}/share/emscripten/cache/ ~/.emscripten_cache
            chmod u+rwX -R ~/.emscripten_cache
            export EM_CACHE=~/.emscripten_cache
          '';

        };


      });
}
