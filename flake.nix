{
  # Inspiration: https://github.com/akirak/flake-templates
  description = "A collection of nix flake project templates";

  outputs = { ... }: {
    templates = {
      c-raylib = {
        path = ./c-raylib;
        description = "Flake starter for C + Raylib";
      };
      go-minimal = {
        path = ./go-minimal;
        description = "Flake for minimal Golang project.";
      };
      python-flask = {
        path = ./python-flask;
        description =
          "Flake for Flask project, includes formatting and linting.";
      };
    };
  };
}
