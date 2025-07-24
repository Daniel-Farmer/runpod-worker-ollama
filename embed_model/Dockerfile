# Stage 1: Preload models
FROM ollama/ollama:0.9.6

ARG MODEL_NAMES
ENV MODEL_NAMES=$MODEL_NAMES
ADD preload_model.sh /preload_model.sh
# Ensure bash is available in the new base image if needed by preload_model.sh
# RUN apk add bash # For Alpine-based ollama images
RUN chmod +x /preload_model.sh && /preload_model.sh

# Stage 2: Copy the model to the volume
FROM ollama/ollama:0.9.6 # Consistent base image for the final layer
COPY --from=0 /runpod-volume /runpod-volume
