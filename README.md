# django-backend cookiecutter template

[![Built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

## Features

- Uses Python 3.8, Django 3.1, Django REST Framework 3.12.
- Python dependencies are managed with [Poetry] package manager.
  - Pins dependencies with `poetry.lock`, ensures reproducibility!
- Built with the [Nix] package manager.
  - Developers, No need to learn Nix! You can use the Python toolset
    you're already familiar with.
  - Ensures end-to-end reproducibility, "it works on my computer" is
    no longer a valid excuse.
- Out of the box support for Amazon S3 (and compatibles) for media
  storage.
  - Don't use Amazon S3? No worries, this project uses [django-storages]
    which supports other object storage backends too!
- Static files served by the backend itself, thanks to [whitenoise].
  - Why setup a separate bucket solely for static files when
    whitenoise is good enough.
- Authentication, registration, verification endpoints preconfigured,
  thanks to [django-rest-authemail].
- Scaffold client libraries quickly with OpenAPI 3.0 schema
  generation, thanks to [drf-spectacular]

[Poetry]: https://python-poetry.org/
[Nix]: https://nixos.org/
[django-storages]: https://django-storages.readthedocs.io/
[whitenoise]: http://whitenoise.evans.io/
[django-rest-authemail]: https://github.com/celiao/django-rest-authemail
[drf-spectacular]: https://github.com/tfranzel/drf-spectacular
