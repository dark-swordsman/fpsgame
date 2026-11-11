# Server Configuration

## Access Model

Two tiers — both fully supported, neither is second-class:

**Guided (non-technical owners)**
- Configuration wizard / UI interface
- Guided setup with sensible defaults
- No config files or CLI required
- Covers the full common configuration surface

**Power user (technical owners)**
- Raw filesystem config files
- Full API access
- Scriptable / automatable
- Nothing locked behind the GUI that isn't also available here

## Configurable Surface (planned)

- Persistence rules: loot loss on death, safe zone definitions, respawn behavior
- Loot density and rarity per zone
- Game mode selection and hooks (via mod system)
- Player limits, whitelist/blacklist
- Economy settings (market update rate, scarcity tuning)
- Mod enable/disable

## Documentation

Documentation is a first-class deliverable — not an afterthought.
- Every config option documented with description, type, default, and example
- Every mod API and hook documented
- Wizard UI should surface the same documentation inline
- Ties directly into the modding-as-core-feature philosophy: if it isn't documented, it doesn't count as exposed

## Notes

See [[Modding API]] for the extension points that server config hooks into.
