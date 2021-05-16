# Statusdeck

Third exercise for the subject 20_SVE2UE at FH OÖ Campus Hagenberg. The exercise is based on the Apollo NodeJS and iOS implementation.

![](.github/promo.gif)

## tl;dr

*tbd*

## 🚩 Goal

Create a GraphQL API and a client for CI/CD pipelines. Enables querying pipelines, builds, steps, commits in a build. The required CI/CD pipeline data will only be simulated.

## 🏗 Architecture

![](.github/architecture.png)

The application itself is based on a three-tier architecture. The backend, written in NodeJS, uses MySQL to persist the data and offers a GraphQL endpoint for a multiplatform SwiftUI app.

## 📝 Requirements

* `docker`
* `node`
* `xcodebuild`

## 🚀 Get started

1. Start the backend and the client
```sh
make bootstrap
```

2. Insert test data
```sh
make test-data
```

## 📱 Showcase

![](.github/apps.png)