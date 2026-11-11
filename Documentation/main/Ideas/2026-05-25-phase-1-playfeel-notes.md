# Phase 1 Playtest Feel Notes — 2026-05-25

> These are loose impressions from the first north star smoke test, not a requirements list. Treat as starting points for discussion, not mandates.

## Context

First playable run of `test_level.tscn` — prototype systems only, placeholder assets, no tuning pass done yet. Goal was to validate that the systems work together, not that they feel great.

## Impressions

- **Crawler activation radius** felt tiny — player could get quite close before the crawler reacted. May want to experiment with a larger `SoundListener` sensitivity radius or lower the threshold.

- **Crawler/player collision** — they collide as hard rigid bodies, which feels wrong. Options: put them on different collision layers so they pass through each other, or apply soft repulsion forces instead of physics collision.

- **Ambient audio is fully global** — wind and water play at fixed volume regardless of position. Could be improved with `AudioStreamPlayer3D` positioned near the water, so audio has natural distance falloff.

- **Player movement feels too fast and light** — walking and running speeds are higher than expected for the "heavy survival" feel. Inertia smoothing may also need to be reduced so stops feel more weighted.

- **Trees are too small** — roughly 1/4 of the desired scale. Easy fix when we revisit the treeline.

- **Bunker door scale** — felt a bit oversized relative to the player.

- **Crawler ground alignment** — appeared to be floating rather than walking on the terrain. May be a navmesh height issue or CharacterBody3D gravity not being applied correctly during PATROL state.
