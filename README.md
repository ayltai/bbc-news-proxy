# BBC News Proxy

A FastAPI-based proxy service for BBC News RSS feeds. This service fetches news articles from BBC's RSS feed and exposes them via a simple REST API.

## Features

- Fetches latest BBC News articles from RSS
- Returns news items with title, description, publication date, and image URL
- CORS enabled for easy frontend integration

## API

### `GET /api/v1/news`

Returns a list of news articles:

```json
[
  {
    "title": "Article Title",
    "description": "Article description...",
    "pubDate": "Mon, 01 Jan 2024 12:00:00 GMT",
    "imageUrl": "https://example.com/image.jpg"
  },
  ...
]
```

## Setup

### Requirements

- Python 3.11+
- Docker (optional)

### Install dependencies

```bash
make venv
source venv/bin/activate
make upgrade
```

### Development

Run the development server:

```bash
make
```

### Production

Run with Uvicorn:

```bash
make prod
```

## Docker

Build and run the Docker image:

```bash
make build
make docker
```

Publish to Docker Hub:

```bash
make deploy
```

## CI/CD

- GitHub Actions for CI (`.github/workflows/ci.yaml`)
- Docker image published on release (`.github/workflows/cd.yaml`)

## License

MIT
