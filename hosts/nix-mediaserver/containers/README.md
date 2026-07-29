# Mediaserver Containers

This directory contains the Docker Compose stack for `nix-mediaserver`.

Use `mediaserver.env.example` as the template and create a env file at `/srv/media/appdata/compose/mediaserver.env`
The stack exists as a systemd service `mediaserver-containers`. The systemd service is skipped until the env file exists.
