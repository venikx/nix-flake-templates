{
  description = "C + Raylib compiled using gcc";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = {
          hello-raylib = pkgs.stdenv.mkDerivation {
            inherit system;
            name = "hello-raylib";
            src = ./src;

            buildInputs = with pkgs; [ raylib ];
            buildPhase = "gcc -o main -lraylib ./main.c ";

            installPhase = ''
              mkdir -p $out/bin
              mv main $out/bin/hello-raylib
            '';
          };

          default = self.packages.${system}.hello-raylib;
        };

        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [ raylib ];

            shellHook = with pkgs; ''
              echo "`gcc --version`"
            '';
          };
        };
      });
}
