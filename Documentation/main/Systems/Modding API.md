---
updated: 2026-06-19
covers:
  - gdextension/modding/src/modding_api/**
  - scripts/autoloads/mod_api.gd
  - scripts/mod_loader.gd
---

# Modding API

## Summary

The Modding API is the connective tissue between all game systems. Its central premise is that the base game is the default mod — every item, weapon, enemy, map, and game mode in the shipped game goes through the same extension points available to community modders. This prevents a two-tier system where the base game has privileged access that mods don't, and means the API gets battle-tested from day one.

Architecturally it has four responsibilities:

1. **Extension points** — Typed registration surfaces where mods declare new content or behaviour (items, weapons, AI, game modes, maps, UI, audio). Systems query the registry rather than hardcoding content lists.
2. **Event bus** — The central nervous system for inter-system communication. Sound propagation, weather changes, AI stimulus, economy ticks — all published through the bus so any system (or mod) can subscribe without tight coupling.
3. **Asset pipeline** — How mod assets are packaged, discovered, loaded, and unloaded. Godot's `.pck` format is the natural fit; the question is how mod packages are structured and validated.
4. **Script exposure layer** — What GDScript / GDExtension APIs mods are allowed to call. This is the trust boundary: some internal APIs are fine to expose, others (networking internals, save file access) need to be gated.

The Modding API is built first in Phase 2. All other Phase 2 systems (Gunplay, AI, Inventory, etc.) are implemented as consumers of it — they prove the API works by being the first mods.

---

## Design Notes & Open Questions

### Scripting

- **Mod scripting:** GDScript only. Engine/core may use GDExtension internally where needed, but mods never need to.
- **Framework mods:** The ecosystem is expected to develop multi-level dependency chains — framework mods (like CBA_A3 in ArmA 3) that extend the platform's modding capabilities, content mods (like ACE3) that both consume framework APIs and expose their own, and leaf mods that depend on both. This is a natural and desirable outcome; the load order and dependency system must support it from the start.
- **Trust tiers:** Five tiers, VRChat-inspired. Trust is informational — it does not gate API access. It signals mod origin and helps server operators and players make informed decisions. Restricting API access by trust level is a possible future extension, not a current requirement.

  | Tier | Meaning |
  |------|---------|
  | Official | Base game content |
  | Trusted | Verified, established organisations |
  | Known | Community mods with confirmed identity |
  | New | Recently registered / unverified |
  | Unknown | Loaded outside the marketplace — operator takes full responsibility |

- **Signing & identity:** Each organisation is uniquely identifiable via a key/hash system (specific mechanism TBD — take inspiration from existing code-signing and package-manager approaches). Code hashes are verified on download so clients can confirm what they're running matches what was published.
- **Mod marketplace:** Aspirational — a first-party marketplace where orgs publish mods. Goal is open, simple, and trustworthy enough that the community defaults to it rather than subverting it with third-party loaders. Steam Workshop integration is a bonus, not a requirement. Loading mods outside the marketplace is always allowed and lands the mod in the Unknown tier. Marketplace design is a separate system — not part of the Modding API itself.

### Event Bus

- **Relationship to Phase 1 SoundBus:** Separate system. `SoundBus` is a Phase 1 prototype; the Modding API event bus is the Phase 2 replacement for inter-system communication. Phase 1 code is not expected to survive unchanged.
- **Typed events:** Events are Resource subclasses. Mods can define and publish their own event types — the bus does not maintain a registry of known types.
- **Domain buses:** Each domain (combat, AI, economy, world, sound, etc.) has its own bus. Mods can create their own buses for their own event domains. Buses can run on separate threads.
- **No cross-bus communication:** Any system or mod subscribes directly to whichever bus it cares about. There is no bridging layer between buses. If the AI module needs to react to combat events, it subscribes to the combat bus directly.
- **Delivery — always buffered:** A bus does three things: accept published events into a buffer, maintain that buffer, and flush the buffer on its tick by calling each relevant subscriber. No synchronous delivery mode, no configurable delivery types. Thread-crossing is the subscriber's responsibility — the bus just calls handlers during its flush.
- **Cancellation:** Not in scope. Revisit if a concrete need arises.
- **Timestamps (open question):** Events could carry a creation timestamp to help with timing-sensitive scenarios (e.g. resolving event order when two buses flush at different rates, or syncing networked events). Potential for abuse (spoofed timestamps, replay attacks). Worth exploring when networking and multiplayer design is more settled — don't design around it now.

### Mod Packaging & Discovery

- **Package format:** Mods can be either a loose folder (for development) or a `.pck` file (for distribution). Godot's `ProjectSettings.load_resource_pack()` mounts `.pck` files into `res://` at runtime, so both formats are treated identically by the loader. Developers can work in a folder and ship a `.pck` without changing anything about how the mod is structured.
- **Discovery:** The game scans a `mods/` directory at startup. Each entry is either a folder or a `.pck`. The loader reads the manifest from each and builds the full dependency graph before any mod is initialised.
- **Manifest:** Each mod declares at minimum: a unique ID, version, display name, and any dependencies (ID + minimum version). Specific manifest format and schema TBD during implementation planning.
- **Dependencies:** Mods can declare dependencies on other mods, including other mods from the community (framework mods, content mods, etc.). Load order is resolved from the dependency graph — dependencies are initialised before their dependents. Open questions to resolve in implementation planning:
  - Circular dependency detection and error handling
  - Missing dependency behaviour (fail to load mod, or fail entire server start?)
  - Version conflict resolution when two mods require incompatible versions of a shared dependency
  - Dependencies on Unknown-tier or potentially malicious packages — trust tier should be visible to the operator before confirming load
- **Hot-reload (dev tooling only):** Because `load_resource_pack()` is a runtime call, hot-reloading a mod without restarting the game is technically feasible. This is useful as a development tool — iterate on a mod without full restarts. Not supported in production multiplayer sessions (would desync clients and server). Flagged for future dev tooling work.

### Extension Points

- **Registration mechanism:** Both auto-discovery (place a Resource in a known folder structure and the loader finds it) and explicit registration (call `register(resource)` from a mod entry-point script) are supported. The entry-point script is the core of actual mod loading — it's where a mod initialises itself, subscribes to buses, and registers content. **Entry-point design is resolved** — see `docs/superpowers/specs/2026-05-28-modding-api-mvp-design.md`. Each mod declares its entry-point GDScript path in its manifest; the loader calls `func initialize(api: ModAPI) -> void` once per mod in dependency order.

- **Override and replace:** Mods can replace content from any other mod, including base game content. Since the base game is itself a mod, "overriding base game content" and "overriding another mod's content" are the same operation. This enables complex and emergent mod interactions — a balance mod overriding a weapon mod's stats, a total conversion replacing everything. This is intentional and desirable.

  However, the design of how overrides work needs proper research before committing to an approach. Key open questions:
  - **Priority model:** Conflict detection + operator-resolved priority override files. When two mods override the same content, the loader alerts the operator and requires resolution. Resolution is recorded in a priority override file — a standalone artifact that declares which mod's version of each conflicted item wins. Override files can be created by the operator, shipped with a modpack, or optionally bundled with a mod as a suggested compatibility patch for known conflicts with other popular mods. This makes conflict resolution versioned, shareable, and modpack-friendly.
  - **Unresolved conflict behaviour** — when a conflict exists and no override file resolves it, does the server refuse to start, fall back to load order with a warning, or let the operator choose? Sensible default TBD; operator-configurable is the likely answer.
  - **Conflict definition** — what exactly constitutes a conflict (same resource path, same content ID, or both) needs a precise definition to avoid false positives or missed real conflicts.
  - **Partial overrides** — can a mod change one field of a Resource without replacing the whole thing, or is it always full replacement?
  - **Override chains** — mod A overrides base, mod B overrides mod A; what does mod C see?
  - **Notification** — does the original mod know it has been overridden? Can it opt out?

  Reference points worth researching before designing: Minecraft Forge's override system, Paradox's mod override declarations, Bethesda's load order model and its known failure modes.

### Networking & Clients

- **Server authority:** The server is always authoritative. Clients must have the same mods loaded as the server to connect. The server dictates what is loaded — clients don't negotiate.
- **Client-side overrides:** Disabled by default. Server operators can explicitly allow them. The default-off stance exists because in a complex FPS, "cosmetic" mods are rarely truly cosmetic — sound replacements can suppress gameplay-relevant audio cues (footsteps, reloads), visual replacements can affect foliage density or environmental readability, and HUD mods can surface information that isn't normally visible. Unlike Minecraft where the block is the atomic gameplay unit and server authority makes local visual changes safe by design, this game's systems are too deeply intertwined for client overrides to be treated as low-risk. Operators who understand the tradeoffs can enable them for their servers.

### Versioning

- **Version format:** The game API and all mods use a semver-derived scheme. Two accepted formats:
  - `x.y.z` — standard semver (major.minor.patch)
  - `x.y.z.a` — extended (major.minor.patch.hotfix) for critical fixes with no API change
  - Dash suffixes allowed for pre-release labels: `1.0.0-rc.1`, `1.0.0-beta.2`, etc. Pre-release versions do not satisfy stable version requirements in dependency resolution.
  - Compatibility is always deterministic — the loader must be able to make a clear accept/reject decision from declared versions alone.
- **Semver semantics:** `x` (major) = breaking change; `y` (minor) = backwards-compatible additions; `z` (patch) = backwards-compatible fixes; `a` (hotfix) = critical fix, no API change.
- **Incompatibility handling** — what happens at load time when a mod declares a minimum version that can't be satisfied? Fail to load the mod, fail server start, or warn and continue? TBD in implementation planning.
- **Deprecation policy** — grace period for deprecated APIs, how mod authors are notified of upcoming breaking changes. TBD.

