# Stage 1: Preload models
FROM ollama/ollama:0.9.6

ARG MODEL_NAMES
ENV MODEL_NAMES=$MODEL_NAMES
ADD preload_model.sh /preload_model.sh
# Install bash if not present in the new base image (ollama images usually have it)
# RUN apt-get update && apt-get install -y bash 
RUN chmod +x /preload_model.sh && /preload_model.sh

# Stage 2: Copy the model to the volume
# Use the same updated base image for consistency, or a minimal runtime image if preferred
FROM ollama/ollama:0.9.6 # <--- CHANGE THIS LINE AS WELL
COPY --from=0 /runpod-volume /runpod-volume
