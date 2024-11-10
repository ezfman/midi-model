FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

RUN apt-get update && apt-get install fluidsynth ffmpeg curl -y

COPY . .

# Download model
RUN mkdir -p models
RUN curl https://huggingface.co/skytnt/midi-model-tv2o-medium/blob/main/model.safetensors -o models/model.safetensors

# Download LORA
RUN mkdir -p loras
RUN curl https://huggingface.co/skytnt/midi-model-tv2om-touhou-lora/blob/main/adapter_config.json -o loras/adapter_config.json
RUN curl https://huggingface.co/skytnt/midi-model-tv2om-touhou-lora/blob/main/adapter_model.safetensors -o loras/adapter_model.safetensors

# Install dependencies
RUN uv add -r requirements.txt

# Launch server
ENTRYPOINT ["uv", "run", "app.py"]