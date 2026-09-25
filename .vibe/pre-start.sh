#!/bin/bash
# AI Memory Pre-Start Hook
# Päivitetään ai-memory repositorio ennen Vibe-käynnistystä

if [ -d "/c/Repos/Omat/ai-memory/.git" ]; then
    echo "[AI-Memory] Päivitetään repositorio..."
    cd /c/Repos/Omat/ai-memory
    git pull 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "[AI-Memory] Repositorio päivitetty!"
    else
        echo "[AI-Memory] Virhe päivityksessä. Yritä manuaalisesti: cd /c/Repos/Omat/ai-memory && git pull"
    fi
fi
