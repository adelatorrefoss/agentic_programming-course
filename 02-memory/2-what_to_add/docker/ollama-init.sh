#!/bin/sh

set -eu

ollama pull "${OLLAMA_CHAT_MODEL}"
ollama pull "${OLLAMA_EMBEDDING_MODEL}"
