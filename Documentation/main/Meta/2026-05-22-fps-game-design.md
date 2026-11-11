---
updated: 2026-11-10
---

# FPS Game Design Spec
*Created: 2026-05-22*

## Overview

A hardcore open-world survival FPS with player-hosted servers, first-class modding support, and an atmosphere-driven design philosophy. Influences: DayZ, STALKER/Misery, Tarkov, Insurgency: Sandstorm, Hunt: Showdown, ARMA.

Engine: Godot 4.7 (Forward Plus, Jolt Physics)

---

## North Star Scene

> Night time. The player faces southwest on a hill sloping down to the right (west). Dense trees and a fuzzy treeline crowd the left. Below: a coastal town near the water. A bunker entrance sits directly in front of the player. Monsters crawl in the dark, reacting to sound. Lighting, audio, and AI are inseparable — cinematic and lived-in.

Every system decision is evaluated against this: *does it make this scene feel more alive?*

---

## Core Design Pillars

1. **Atmosphere first** — lighting, sound, and AI work together
2. **Modding as a first-class feature** — the base game is the default mod; all systems exposed via the same API community modders use
3. **Player agency** — personal safe bunker, player-hosted servers, community-driven
4. **Authentic feel without simulation hell** — weighty and grounded, not spreadsheet management

---

## Tone & Setting

- Eastern European aesthetic — Chernarus / STALKER-style terrain and architecture
- Typically depressing weather: overcast, rain, fog, snow
- Day/night cycle; night is a gameplay element
- Anomalies, monsters, and human threats coexist
- Grounded and tense — not goofy

---

## Multiplayer & Distribution

- Player-hosted servers (DayZ/ARMA model); community carries the load
- Source-available code (Minecraft model)
- Steam distribution; Steam-authenticated server mode rejects custom-compiled clients
- Server operators can configure all persistence and gameplay rules
- Steam auth implementation method (Steamworks GDExtension vs. custom handshake) is an open question that must be resolved before Phase 3 begins

---

## Persistence & Death (Default)

- DayZ-style: die and lose everything carried on your person
- Bunker stash persists across deaths
- Respawn at shore (default) or bunker bed
- All rules configurable per server via mod/config system

---

## Build Strategy

The roadmap order lives in [[TODO]] (base game first, then modding, then optimization). Tasks are tracked as GitHub issues.

---

## Phase 1: The North Star Scene

**Goal:** A playable mood proof-of-concept. Not a game — a feeling. Stand on the hill at night, hear the world, feel something.

> [!todo] Define the core loop
> The mood scene is the first target, but the vibe isn't a loop. A clearer core gameplay loop still needs to be defined beyond the mood/atmosphere idea.

**Deliverables:**
- First-person player controller: walk, look, Tarkov-style inertia
- Hand-crafted test level: hill sloping west, treeline left, coastal town silhouette below, bunker entrance ahead
- Night-time lighting: moon, ambient — no artificial light, just darkness
- Basic ambient sound: wind, distant water, environmental hum
- One enemy: a crawler/zombie that patrols and reacts to sound within a radius
- Bunker entrance: interactable door (placeholder — interior and architecture TBD)

**Explicitly out of scope:** guns, inventory, multiplayer, saving, persistence.

**Note on the bunker entrance:** Whether the bunker is instanced or a physical world space is an open question (see below). The Phase 1 entrance is a placeholder regardless — it establishes the visual and interactive anchor without committing to either architecture.

**Note on the test level:** This is a hand-crafted prototype scene, not the production map. Map size and generation method (hand-crafted, procedural, modular) is an open question. The Phase 1 level will not necessarily be carried forward.

---

## Phase 2: Systems

Each system built as a proper vertical slice, tested in the Phase 1 scene. For now, systems are built directly in the game; the modding API comes later (see [[TODO]]), at which point systems may be reworked to go through it.

### 2.1 Modding API (Deferred)
Comes after a working base game. See [[Modding API]] for the design notes.
- Extension points: items, weapons, AI behaviors, maps, game modes, UI, sound/assets
- Resource loading system for mod assets
- Script exposure layer (what GDScript/GDExtension APIs mods can call)
- Event bus for inter-system communication
- Server-side mod enable/disable per server operator

### 2.2 Gunplay
- One weapon to start
- Time-delayed hitscan ballistics: path calculated on fire (with bullet drop), hit resolved after travel-time delay; if target moves out of path during travel, it misses
- Recoil: somewhere in the Tarkov / STALKER / CSGO ballpark — refined through iteration
- Hipfire: usable at close range (~10-20m), degrades at range
- ADS: meaningful accuracy improvement
- Ammo system: caliber, type (FMJ/HP/AP/Dum-Dum), armor penetration, velocity, damage
- Magazine system: capacity, reload speed modifier, jam chance
- **Ballistics must expose velocity as a modifiable parameter** — barrel length and suppressor effects (added in 2.6) modify the same velocity value; design for this extension now

### 2.3 AI
- AI reacts to sound events: position, radius, intensity
- NavigationAgent3D-based pathfinding
- Behavior states: patrol → alert → investigate → chase → attack
- Enemy type 1: zombie/crawler (common)
- Enemy type 2: anomaly creature (rare, event/zone-tied)

### 2.4 Inventory
- The grid provides spatial/visual layout; weight is the primary capacity constraint
- Items are placed freely on the grid (no forced Tetris shapes); weight limit is what stops you from taking everything
- Auto-stack and auto-sort functions
- Item data model: all properties defined in data resources (so they can be exposed to mods later)
- Actions: pick up, drop, share with players, access dead player inventory
- **Note on crafting:** if crafting is added later, item data model and storage will need to support ingredient/recipe relationships. Design item data model to be extensible on this axis even if crafting is not built yet.

### 2.5 World & Weather
Sound propagation modifiers are published to the event bus (pending whether the event bus will still be a thing); AI and other systems consume them.
- Dynamic weather: overcast, rain, fog, snow
- Day/night cycle with dynamic lighting
- Weather affects sound propagation (e.g. rain raises the ambient noise floor, masking footsteps)
- Foliage, terrain detail tuning

### 2.6 Weapons & Attachments
Consumes and extends the ballistics velocity parameter established in 2.2.
- Attachment rail system: Dovetail, Picatinny
- Attachment types: suppressors, optics, grips, barrels (at minimum)
- Suppressor: slightly *increases* velocity (acts as a barrel extension), reduces sound signature (lower-intensity sound for AI to react to), and increases jam chance (higher backpressure into the action from gun gassing) — modeled closer to real life than the common game trope of velocity reduction
- Barrel length: longer = higher velocity, more weight, worse ergonomics, larger physical footprint (harder to maneuver in tight spaces); shorter = lower velocity, lighter, faster handling, better CQB
- Durability: items degrade with use

### 2.7 Medical
- Health system: basic HP, body part damage (depth TBD)
- Healing items: bandages, medkits, etc.
- Contributes to survival tension without micromanagement
- **References:** ACES medical system (ARMA 3) for depth and UX inspiration; Tarkov for ballistics interaction with body health
- **UX reference (ACES):** hotkeys to initiate treatment + visual drag/selection UI + context-sensitivity based on which body part the player is looking at — this interaction model is worth carrying forward even if the underlying depth is reduced
- Base game will be simpler than either reference; exact depth TBD through iteration

*Vehicles: backburner — revisit after Phase 3.*

---

## Phase 3: The Loop

Wire all systems into a real game loop.

### 3.1 Persistence & Spawn
- Bunker safe stash: gear stored here survives death
- Shore spawn: default respawn locations
- Bed spawn: respawn at bunker if bed placed
- All configurable by server operators
- Requires bunker architecture decision (open question below) before implementation

### 3.2 Economy & Trading
- AI traders in the world (STALKER/Tarkov style)
- Player-to-player trading
- Economy balance: ammo scarcity intentional, not punishing
- **Dynamic market system:** global item values fluctuate over time based on a lightweight system that mimics real market conditions (supply/demand, scarcity events, etc.) — not deeply simulated, but enough that prices feel alive and player behavior can influence them

### 3.3 Multiplayer & Networking
- Player-hosted dedicated servers
- Steam auth layer: Steam-verified servers reject custom-compiled clients
- Authentication model: algorithm public, secrets not (password-hash analogy)
- Server browser: first-class, better than DayZ's
- **Implementation method for Steam auth is an open question** — Steamworks GDExtension, custom handshake, or hybrid; must be resolved before 3.3 begins

### 3.4 Server Configuration
- Persistence rules (loot loss on death, safe zones, etc.)
- Loot density, rarity settings
- Game mode hooks via mod system
- **Two-tier access model:**
  - GUI wizard/interface for non-technical server owners — guided setup, sensible defaults, no config files required
  - Raw API and filesystem access for power users — nothing is hidden or locked behind the GUI
- **Documentation is a first-class deliverable** — every config option, API, and mod hook must be documented; this is part of the modding-as-core-feature philosophy

---

## Feedback & Iteration

- Nephew is a primary playtester and feedback source, particularly around gun mechanics and feel
- Gun design decisions (recoil, handling, attachment balance) should be validated against this feedback loop before being locked in
- Design in this area should remain flexible and iterative

---

## Open Questions

**Must be resolved before Phase 3:**
- Bunker: instanced (private, off-world) or physical entrance in the world? These are architecturally incompatible — decision required before 3.1
- Steam auth: Steamworks GDExtension vs. custom token handshake vs. hybrid? Required before 3.3

**Can be deferred:**
- Bunker: raidable at all, or always safe?
- Bunker: upgradeable over time (Tarkov hideout style)?
- Body part damage: how granular (STALKER-light vs Tarkov-deep)?
- Anomalies: purely environmental hazard or also AI-driven?
- Crafting: in scope? If yes, flag before finalizing inventory data model in 2.4
- Map size and generation: Chernarus scale, larger, modular, or procedural? Phase 1 level is a prototype and does not commit to any answer
