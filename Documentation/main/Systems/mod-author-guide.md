# Mod Author Guide

## How mods plug into the game

![[mod-architecture.mermaid]]

A mod is a folder the engine discovers at startup. It can do three things:

| What | How | Effect |
|------|-----|--------|
| Add content | `ContentRegistry.register(...)` | Items, enemies, weapons become available in the world |
| Add behaviour | `register_processor(fn, hz)` | Your function runs every sim tick against all active entities |
| React to game events | `DomainBus.subscribe(event, handler)` | Called whenever something happens (entity spawned, player died, etc.) |

## The sim tick

Processors are the main place mods affect entity behaviour. Each tick, StateSystem calls every
registered processor and hands it the entity list plus component data (position, velocity, health,
etc.). The processor reads and writes that data; StateSystem handles threading and buffering.

```
tick N:
  for each processor:
    processor.fn(dt, active_entities, component_pools)
```

## What mods do NOT do

- Replace core systems (StateSystem, ModAPI) — these are infrastructure, not extension points
- Own the game loop — StateSystem drives the tick rate; mods respond to it
- Communicate directly with each other — use DomainBus events for cross-mod signalling
