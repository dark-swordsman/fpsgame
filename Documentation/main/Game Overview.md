# Game Overview

---

Disclaimer: A lot of these docs were written with AI in the previous iteration of this project. They still hold a lot of the core ideas and goals, but they need to be gone through and verified for accuracy. Until this disclaimer is removed, take every line in these docs with a grain of salt.

---

A hardcore open-world survival FPS with player-hosted servers, first-class modding support, and a cinematic, atmosphere-driven design philosophy.

## North Star Scene

> Night time. The player faces southwest on a hill that slopes down to the right (west). Dense trees and a fuzzy treeline crowd the left. Below: a coastal town near the water. A bunker entrance sits directly in front of the player.
>
> Monsters crawl through the dark, responding to sounds. The lighting, audio, and AI are inseparable — all tied together into something that feels cinematic and lived-in.

This scene is the emotional target. Every system decision should be measurable against it: *does this make that scene feel more alive?*

---

## Influences

| Game | What we take from it |
|---|---|
| DayZ | Open world, player-hosted servers, survival tension |
| STALKER / Misery | Atmosphere, anomalies, ammo scarcity, tight gunfeel |
| Tarkov | Inventory depth, ballistics, personal hideout/safe space |
| Insurgency: Sandstorm | Realistic gunplay, slow deliberate movement |
| Hunt: Showdown | Sound as gameplay, high risk/high reward |
| ARMA | Military authenticity, moddability |

---

## Core Design Pillars

1. **Atmosphere first** — lighting, sound, and AI must work together
2. **Modding as a first-class feature** — the base game is just the default mod; game modes, items, maps all exposed via a clean API *(planned for after the base game; see [[TODO]])*
3. **Player agency** — personal safe space (bunker), player-hosted servers, community-driven
4. **Authentic feel without simulation hell** — realistic enough to feel weighty, not so deep it's inaccessible

---

## Tone

- Typically depressing weather / seasons
- Eastern European aesthetic (Chernarus / STALKER-style map and architecture)
- Anomalies and monsters alongside human threats
- Not goofy — grounded, tense, cinematic

---

## Multiplayer & Distribution

- Player-hosted servers (DayZ/ARMA model)
- Source-available code (Minecraft model)
- Steam distribution — Steam-authenticated servers can reject custom-compiled clients
- Official servers possible but community carries the load

---

## Modding Philosophy

*Planned for after the base game; see [[TODO]].*

- Game modes are mods; the core is an engine for mods
- Clean, documented mod API — easier than ARMA/DayZ
- Standard extension points: items, weapons, maps, AI, game modes, UI

---

## Major Systems (links)

- [[Gunplay]]
- [[Movement]]
- [[Inventory]]
- [[AI]]
- [[Environment|World & Environment]]
- [[Weapons & Attachments]]
- [[Medical]]
- [[Vehicles]]
- [[Spawn System]]
- [[Economy & Trading]]
- [[Bunker - Safe Base|Bunker / Safe Base]]
- [[Multiplayer & Networking]]
- [[Modding API]]
