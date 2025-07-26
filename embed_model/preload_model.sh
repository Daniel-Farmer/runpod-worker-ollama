#!/bin/bash

# Start the Ollama server in the background for preloading.
echo "🚀 Starting Ollama server to preload models: $MODEL_NAMES"
ollama serve &
OLLAMA_PID=$!

# Wait for the server to be ready.
echo "⏳ Waiting for Ollama server to start..."
sleep 5

# Inject Hugging Face token from Runpod Secrets
HF_SECRET_PATH="/runpod-volume/secrets/RUNPOD_SECRET_HF_TOKEN"
if [ -f "$HF_SECRET_PATH" ]; then
    export HUGGINGFACEHUB_API_TOKEN=$(cat "$HF_SECRET_PATH")
    echo "✅ Hugging Face token injected from secrets"
    echo "🔐 Token length: ${#HUGGINGFACEHUB_API_TOKEN}"
    echo "🔑 Token SHA256: $(echo -n "$HUGGINGFACEHUB_API_TOKEN" | sha256sum | cut -d ' ' -f1)"
else
    echo "❌ RUNPOD_SECRET_HF_TOKEN not found in /runpod-volume/secrets"
    kill $OLLAMA_PID
    exit 1
fi

# Split the comma-separated model names into an array.
IFS=',' read -r -a MODELS <<< "$MODEL_NAMES"

# Loop through each model and pull it.
for MODEL_NAME in "${MODELS[@]}"; do
    echo "📦 Pulling model: $MODEL_NAME"
    if ollama pull "$MODEL_NAME"; then
        echo "✅ Successfully pulled model: $MODEL_NAME"
    else
        echo "❌ Failed to pull model: $MODEL_NAME"
        kill $OLLAMA_PID
        exit 1
    fi
done

# Stop the Ollama server after preloading.
echo "🛑 Stopping Ollama server..."
kill $OLLAMA_PID
wait $OLLAMA_PID
echo "✅ Model preloading complete."
