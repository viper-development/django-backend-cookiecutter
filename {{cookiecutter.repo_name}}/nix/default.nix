{ sources ? import ./sources.nix }:

let
  # Setup nixpkgs with overlays.
  pkgs = import sources.nixpkgs {
    overlays = [
      (import "${sources.poetry2nix}/overlay.nix")
    ];
  };

  # Python package overrides in case dependencies fails when building with Nix.
  overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {});

  # Environment with only runtime dependencies.
  dependencyEnv = (pkgs.poetry2nix.mkPoetryApplication {
    projectDir = ./..;
    overrides = overrides;
  }).dependencyEnv;

  # Environment with both runtime and dev dependencies.
  developmentEnv = pkgs.poetry2nix.mkPoetryEnv {
    projectDir = ./..;
    editablePackageSources.app = ./..;
    overrides = overrides;
  };

  # Shell environment definition
  shell = pkgs.mkShell {
    buildInputs = with pkgs; [
      developmentEnv

      # If you need additional tools that are out of Python's reach,
      # Add them here.
      poetry
      niv
    ];
  };
in
{
  default = dependencyEnv;

  inherit shell;
}
