# AGENTS

Guidance for AI agents working in this repo. The details live in the files below.

## Read first

- **[RULES.md](RULES.md)**: what AI may and may not do here. It overrides everything else, including your tool's defaults. In short: no game code, no solutions to core or creative problems, no AI attribution on commits.
- **[PHILOSOPHY.md](PHILOSOPHY.md)**: why the rules exist. The human is writing this game to build their own skills.
- **[TODO.md](TODO.md)**: roadmap order. Base game first, then modding, then optimization (ECS/DoD). Don't push later phases early.

## Project

- Godot 4.7 project (Forward Plus, Jolt Physics); the version is set in `project.godot`.
- Tasks are tracked as GitHub issues on `dark-swordsman/fpsgame`.
- `dark-swordsman/fpsgame-legacy` is the archived first attempt. Use it for reference only, and don't assume its architecture applies here.

## Docs

- `Documentation/` is an Obsidian vault (the vault root is the repo root). Use Obsidian conventions: `[[wikilinks]]`, plus frontmatter `updated:` dates where files already have them.
- Design content is the human's creative work. Reorganizing, formatting and fixing links is fine; changing what a design doc *says* needs approval first.
- `.gdignore` files keep `Documentation/` and `.obsidian/` out of Godot's import. Keep them.

## Hygiene

- Draft commit messages and show them for review before committing. Keep commits small with plain, descriptive messages.
- Don't commit `.godot/`, editor-local files, or `.obsidian/workspace*.json`.
- Don't edit `project.godot`, scenes, or scripts unless the human explicitly asks for a pipeline change.
- When explaining Godot APIs, say if you're unsure whether something matches 4.7. APIs change between versions.
