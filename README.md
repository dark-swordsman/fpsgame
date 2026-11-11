# fpsgame

This is a FOSS FPS game project designed to be modded and extended by the community.

The goal is to provide a solid substrate for users to build upon.

## Why?

Primarily: I used to play older zombie/survival PC games (you know the ones) and, individually, they were fun, but they each had their own limitations.

The goal here is to create a generic system that can be expanded upon more easily. Pretty much every aspect of the game can be modified, instead of adhering to a strict set of game code that must be painstakingly reverse engineered and modified.

## Modules

Modularity will be built into the core of the game.

Each module will be loaded into the game like you would expect of any mod loader, and mods can depend on each other. Every module can consume or expose an API through a standard system.

It won't be this way at the start, but this is the end goal.

## Status

This is a fresh restart of an earlier attempt. Nothing is playable yet; the current focus is getting a basic game working before modding or optimization. See [TODO.md](TODO.md) for the roadmap.

## Getting Started

1. Install [Godot 4.7](https://godotengine.org/download).
2. Clone this repo.
3. Open `project.godot` in Godot.

## Docs

- [`Documentation/`](Documentation/) is the design vault. It's set up for [Obsidian](https://obsidian.md) (open the repo root as a vault), but it's plain Markdown and reads fine anywhere. Start with [Game Overview](Documentation/main/Game%20Overview.md).
  - Obsidian plugins aren't committed, only the list of enabled ones. Install these from Obsidian's community plugin browser:
    - **Mermaid View**
    - **Excalidraw**: set *Settings → Excalidraw → Excalidraw folder* to `Documentation/sketches`, so new drawings stay inside the docs and out of Godot's import.
- [PHILOSOPHY.md](PHILOSOPHY.md) explains how and why I'm working on this.
- [TODO.md](TODO.md) is the roadmap. Actual tasks live in GitHub issues.

## AI Usage Disclaimer

All game code in this repo is written by humans. AI is only used for workflow, project management, and answering questions, under the rules in [RULES.md](RULES.md). See [AI.md](AI.md) for details.

## License

MIT. See [LICENSE](LICENSE).