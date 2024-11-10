FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

RUN apt-get update && apt-get install fluidsynth ffmpeg -y

COPY . .
# Download model
RUN mkdir models
RUN curl https://huggingface.co/skytnt/midi-model-tv2o-medium/blob/main/model.safetensors models/model.safetensors

# Download LORA
RUN mkdir loras
RUN curl https://huggingface.co/skytnt/midi-model-tv2om-touhou-lora/blob/main/adapter_config.json loras/adapter_config.json
RUN curl https://huggingface.co/skytnt/midi-model-tv2om-touhou-lora/blob/main/adapter_model.safetensors loras/adapter_model.safetensors

# Install dependencies
RUN uv add -r requirements.txt

# Launch server
ENTRYPOINT ["uv", "run", "app.py"]