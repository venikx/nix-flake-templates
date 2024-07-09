{
  description = "Minimal Golang application packaged using gomod2nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
  outputs = { self, nixpkgs, flake-utils, gomod2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        version = builtins.substring 0 8 self.lastModifiedDate;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ gomod2nix.overlays.default ];
        };
      in {
        packages = {
          myapp = pkgs.buildGoApplication {
            inherit version;
            pname = "myapp";
            src = ./.;
            modules = ./gomod2nix.toml;
          };
          default = self.packages.${system}.myapp;
        };

        devShells.default = with pkgs;
          pkgs.mkShell {
            inputsFrom = [ self.packages.${system}.myapp ];
            packages =
              [ gopls gotools go-tools gomod2nix.packages.${system}.default ];
          };
      });
}
