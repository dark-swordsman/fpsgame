# Multiplayer & Networking

> [!warning] Legacy reference, may need rework
> Written during the previous iteration, which ran a networking spike against its own architecture. This whole approach may need to be redone or reworked for this version of the project.

## Server Model

- Player-hosted servers (DayZ/ARMA model)
- Community carries the load; official servers possible but not primary
- Server browser — finding servers is a known pain point in DayZ; should be better

## Distribution & Auth

- Source-available code (Minecraft model)
- Steam as primary distribution
- Steam-authenticated server mode: servers can require Steam auth, rejecting custom-compiled clients
- Authentication scheme inspired by password hashing — algorithm is public, secrets are not

## Authority Model & Netcode Direction

- **Server-authoritative on inputs** (not on positions): clients send *inputs*, the server runs the simulation and produces canonical state. Kills movement/teleport/speed cheats structurally rather than by heuristic. Responsiveness comes from **client-side prediction + reconciliation**, not from client authority. See the networking spike spec in `fpsgame-legacy`: `docs/superpowers/specs/2026-07-02-networking-spike-design.md`.
- Trust is *relative to the connected clients*. Player-hosted means a malicious host is a separate threat — addressed by server reputation / Steam-verified builds, not by the authority model.

### Future goalpost — precise input timestamps / sub-tick-style resolution

- Input-authoritative + numbered ticks opens the door to **sub-tick resolution** (CS2-style): stamp each input with *when in the tick window* it truly happened (`t_offset`), so hit/timing determinations aren't quantized to the tick rate. An input path would carry a per-input sequence number; adding a timestamp is a natural extension of the same field, not a re-architecture.
- Likely aligns with the **progressive / time-delayed hitscan** gunplay idea — timing-sensitive shot resolution wants the same precise-timestamp substrate.
- Honest caveats (why this is an *aim-point*, not a settled plan):
  - **Distinct from lag compensation.** Sub-tick answers *"exactly when did the input happen?"*; deciding *"who wins a duel"* also needs lag comp (rewinding the world to what the shooter saw). Fair duels need both.
  - **The timestamp is client-reported → a trust surface.** A cheater can lie about timing; it must be bounded + validated server-side. Sharper for us because of player-hosted servers.
  - **Sub-tick is contested.** CS2's implementation drew real "doesn't feel as clean as 128-tick" criticism. Aim at it deliberately; don't treat it as obviously correct.

## Notes

- Modding infrastructure must be designed with networking in mind from the start
- Custom clients on community servers may be fine (moddable); Steam-verified servers should be protected
