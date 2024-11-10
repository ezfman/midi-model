FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# WORKDIR /app
RUN apt-get update && apt-get install fluidsynth -y

# COPY . /app
COPY . .
RUN uv add -r requirements.txt

ENTRYPOINT ["uv", "run", "app.py"]