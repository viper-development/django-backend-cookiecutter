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

  # Source folder with .gitignore applied
  src = pkgs.poetry2nix.cleanPythonSources {
    src = ./..;
  };

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

  # Static files required on runtime
  static = pkgs.runCommand "{{cookiecutter.project_name}}-static" {}
    ''
    mkdir $out
    export STATIC_ROOT=$out
    export SECRET_KEY=fake
    export DATABASE_URL=fake
    export EMAIL_URL=fake
    ${dependencyEnv}/bin/python ${src}/manage.py collectstatic --noinput
    '';

  # Docker image
  docker = pkgs.dockerTools.buildImage {
    name = "{{cookiecutter.project_name}}";

    extraCommands =
      ''
      mkdir ./tmp
      chmod 1777 ./tmp
      '';

    contents = with pkgs; [
      busybox

      (writeScriptBin "{{cookiecutter.project_name}}-init"
        ''
        #!${runtimeShell}
        set -e -x

        ${dependencyEnv}/bin/python manage.py migrate

        exec ${dependencyEnv}/bin/gunicorn \
          --bind=0.0.0.0:8000 --access-logfile - \
          {{cookiecutter.project_name}}.wsgi:application
        '')
    ];

    config = {
      Cmd = [ "{{cookiecutter.project_name}}-init" ];
      Env = [ "STATIC_ROOT=${static}" ];
      WorkingDir = src;
      User = "1000";

      ExposedPorts = {
        "8000" = {};
      };
    };
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

  inherit docker;
  inherit shell;
}
