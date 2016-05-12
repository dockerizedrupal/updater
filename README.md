> **Notice:** *This project is part of the [Dockerized Drupal](https://dockerizedrupal.com/) initiative.*

# Updater

Helps you to keep your Dockerized Drupal tools up-to-date.

## Install

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/updater.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 0.1.1 \
      && sudo cp "${TMP}/updater.sh" /usr/local/bin/updater \
      && sudo chmod +x /usr/local/bin/updater \
      && cd -

## License

**MIT**
