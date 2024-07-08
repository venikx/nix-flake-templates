{
  # Inspiration: https://github.com/akirak/flake-templates
  description = "A collection of nix flake project templates";

  outputs = { ... }: {
    templates = {
      python-flask = {
        path = ./python-flask;
        description =
          "Flake for Flask project, includes formatting and linting.";
      };
    };
  };
}
