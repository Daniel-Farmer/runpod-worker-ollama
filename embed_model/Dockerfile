# Stage 1: Preload models
# Use a recent, official Ollama base image that is known to work well with hf.co pulls.
# 0.9.6 matches the version seen in your logs.
FROM ollama/ollama:0.9.6 [cite: 4]

ARG MODEL_NAMES
ENV MODEL_NAMES=$MODEL_NAMES
ADD preload_model.sh /preload_model.sh

# Ensure bash is available in the new base image if needed by preload_model.sh.
# 'ollama/ollama:0.9.6' is usually Debian-based, so apt-get is appropriate.
# (If it were Alpine, you'd use 'apk add bash')
RUN apt-get update --yes --quiet && DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Execute the preloading script
RUN chmod +x /preload_model.sh && /preload_model.sh

# Stage 2: Copy the model to the volume for the final image
# Use the same updated base image for consistency
FROM ollama/ollama:0.9.6 [cite: 4]
COPY --from=0 /runpod-volume /runpod-volume
