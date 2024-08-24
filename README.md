# Website

This website is built using [Docusaurus 2](https://docusaurus.io/), a modern static website generator.

[https://richardjm.github.io/](https://richardjm.github.io/)

## Docker

Runs in docker with dev container sync for `docs`, `static`, and `src`.

Along with volumes for the time-consuming `node_modules` and `docusaurus`.

```cmd
docker compose up --build
docker compose up -d
docker compose watch
```
