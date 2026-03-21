# Website

This website is built using [Docusaurus](https://docusaurus.io/), a modern static website generator.

[https://richardjm.github.io/](https://richardjm.github.io/)

## Development

```powershell
npm install
npm start       # dev server at http://localhost:3000
npm run build   # production build into ./build
npm run serve   # serve the production build locally
npm test        # run Playwright tests (requires a build first)
```

## CI / GitHub Actions

### PR Build (`pr-build.yml`)

Triggered on pull requests to `main`, or manually via the Actions UI (workflow_dispatch).

Steps:

1. Checkout
2. Run the shared composite action (install, build, Playwright tests)
3. Publish test results as a GitHub Check (visible in the PR without downloading)
4. Upload the HTML Playwright report as an artifact

### Deploy (`deploy.yml`)

Triggered on push to `main`. Builds the site and deploys to GitHub Pages.

Upload and deploy steps are skipped when detected as a local `act` run.

## Running GitHub Actions locally

Requires [podman](https://podman.io/) and [act](https://github.com/nektos/act).

```powershell
# Run the PR build workflow locally
.\run-actions-local.ps1

# Run the deploy workflow locally (build only, no upload/deploy)
.\run-actions-local.ps1 -Workflow deploy
```

The script:

- Starts the Podman machine if not already running
- Detects the correct `DOCKER_HOST` endpoint from the running machine
- Runs `act` using `ghcr.io/catthehacker/ubuntu:full-latest` as the ubuntu-latest image
- Skips upload/deploy steps that are not meaningful locally
