# Stage 1: Preload models
# Use a recent, official Ollama base image (0.9.6 matches your observed running version).
FROM ollama/ollama:0.9.6 [cite: 4]

ARG MODEL_NAMES
ENV MODEL_NAMES=$MODEL_NAMES
ADD preload_model.sh /preload_model.sh

# Ensure bash is available in this base image for the preload_model.sh script to run.
# 'ollama/ollama' images are typically Debian-based, so 'apt-get' is correct.
# The original logs show some apt-get commands being run.
RUN apt-get update --yes --quiet && DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Execute the preloading script. This is where the 'ollama pull' command runs.
RUN chmod +x /preload_model.sh && /preload_model.sh

# Stage 2: Create the final image with the preloaded models.
# Use the same updated base image for consistency.
FROM ollama/ollama:0.9.6 [cite: 4]
COPY --from=0 /runpod-volume /runpod-volume
