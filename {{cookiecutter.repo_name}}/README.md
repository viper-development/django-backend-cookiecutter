# {{cookiecutter.project_name}} backend

[![Built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

## Setup local environment

### Install dependencies

#### Method 1. Nix (recommended)

##### Requirements

1. [Nix package manager][nix install]
2. (Optional) [direnv][direnv install] along with [direnv integration]
   on your editor.
3. (Optional) [lorri][lorri install]

[nix install]: https://nixos.org/download.html#nix-quick-install
[lorri install]: https://github.com/nix-community/lorri#setup-on-nixos-or-with-home-manager-on-linux

##### Start your `nix-shell`

With direnv configured, you can simply run the following command to
allow the `.envrc` file:

```console
$ direnv allow
```

After the command above is executed, you should be inside the virtual
environment everytime you enter this project's directory.

If direnv is not present, simply run the following command to spawn a
shell in the virtual environment:

```console
$ poetry shell
```

#### Method 2. Poetry

##### Requirements

1. [Poetry package manager][poetry install]
2. (Optional) [direnv][direnv install] along with [direnv integration]
   on your editor.

[poetry install]: https://python-poetry.org/docs/#installation

##### Start your `poetry shell`

With direnv configured, you can simply run the following command to
allow the `.envrc` file:

```console
$ direnv allow
```

After the command above is executed, you should be inside the virtual
environment everytime you enter this project's directory.

If not, simply run the following command to spawn a shell in the
virtual environment:

```console
$ poetry shell
```

### Setup your local configuration

This project uses environment variables for configuration.

However, you don't need to define them each time, you can use the
`{{cookiecutter.project_name}}/.env` file.

If it doesn't exist, simply use
`{{cookiecutter.project_name}}/.env.example` as
a starting point:

```console
$ cp {{cookiecutter.project_name}}/.env.example {{cookiecutter.project_name}}/.env
```

[direnv install]: https://direnv.net/docs/installation.html
[direnv integration]: https://github.com/direnv/direnv/wiki#editor-integration

## Build Docker image

The Docker image is built with Nix. Therefore, you're required to have
it installed.

To build, simply run `nix-build` with the `docker.nix` file:

```console
$ nix-build docker.nix
```

To import the image to your Docker daemon, simply load the `result`
symlink:

```console
$ docker load -i result
```

You should be able to see the image tag as the last line.
