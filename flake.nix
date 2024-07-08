{
  # Inspiration: https://github.com/akirak/flake-templates
  description = "A collection of nix flake project templates";

  outputs = { ... }: {
    templates = {
      meta = {
        path = ./python-flake;
        description =
          "Flake for Flask project, includes formatting and linting.";
      };
    };
  };
}
