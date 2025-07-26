# Runpod serverless runner for ollama

## How to use

Start a Runpod serverless with the docker container `svenbrnn/runpod-ollama:latest`.  
Set the `MODEL_NAME` environment variable to a model from ollama.com to automatically download it.  
A mounted volume will be automatically used.

[![RunPod](https://api.runpod.io/badge/SvenBrnn/runpod-worker-ollama)](https://www.runpod.io/console/hub/SvenBrnn/runpod-worker-ollama)

## Environment variables

| Variable Name            | Description                                        | Default Value |
|--------------------------|----------------------------------------------------|----------------|
| `MODEL_NAME`             | The name of the model to download                  | NULL           |
| `RUNPOD_SECRET_HF_TOKEN` | Hugging Face token for private model authentication | NULL           |


## Test requests for runpod.io console

See the `test_inputs` directory for example test requests.

## Streaming

Streaming for OpenAI-style requests is fully supported.

## Preload model into the docker image

See the `embed_model` directory for instructions.

## Private model access via Hugging Face

To preload private models from Hugging Face:

1. Create a read-access token at https://huggingface.co/settings/tokens

2. Store it in Runpod Secrets with the key:  
   `RUNPOD_SECRET_HF_TOKEN`

3. Use Hugging Face model slugs like:  
   `mistralai/Mistral-7B-Instruct-v0.3`

4. The `preload_model.sh` script will automatically inject the token before `ollama pull`.  
   SHA256 hash and token length are logged for audit—never the full token.

## Licence

This project is licensed under the Creative Commons Attribution 4.0 International License.  
You are free to use, share, and adapt the material for any purpose, even commercially, under the following terms:

- **Attribution**: You must give appropriate credit, provide a link to the license, and indicate if changes were made.  
  You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

- **Reference**: You must reference the original repository at  
  https://github.com/svenbrnn/runpod-worker-ollama

For more details, see the license: https://creativecommons.org/licenses/by/4.0/
