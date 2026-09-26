# AGENTS.md — RASP

Guidance for AI agents (Mistral Vibe) working in this repository. Global
rules live in `~/.vibe/AGENTS.md`.

## Project purpose

Audio scripting project (RASP). Repositories live under `/mnt/data/Repos/`.

## Central AI memory

All notes, documentation, learnings and logs for this project are stored in
the central memory repository:

```
/mnt/data/Repos/ai-memory/projects/RASP/
```

At session start run `git -C /mnt/data/Repos/ai-memory pull --ff-only`.
After saving notes there, always commit and push ai-memory. Never store
API keys or other secrets in any repository.
