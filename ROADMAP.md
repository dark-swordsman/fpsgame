# ROADMAP

Status: `[ ]` not started · `[~]` in progress · `[x]` done

## Phase 1: Base game

**Goal:**

Get a core game loop working that satiates the classic zombie/survival experience.

**Done when:**

The game is functionally playable in singleplayer and an enjoyable experience can be had. The exact finish line is vague and is more based on vibes.

To note: Singleplayer means connecting to the server and having it respond properly to events and stuff so the game loop is satiated. Proper multiplayer support can be handled as part of later Milestones under 1 or as part of 2.

### Milestone 1.1:

Inventory: A Basic Inventory System
See [Inventory](Documentation/main/Systems/Inventory.md)

This would also inherently include the concept of Items

- [ ] May need to formalize the PlayerCharacter into a script so it can interface with things involved with it
- [ ] A core inventory class
- [ ] Inventory UI (player based at first)
- [ ] A core item class
- [ ] An API to read/write that inventory
- [ ] Enforcing weight limits
- [ ] An API to pickup/manage items

### Milestone 1.2:

Maps and Scenarios
See [Environment](Documentation/main/World/Environment.md) (kinda)
See [Spawn System](<Documentation/main/Systems/Spawn System.md>)
See [Server Configuration](<Documentation/main/Systems/Server Configuration.md>)

- [ ] Scenario class, defining map, conditions, rules, etc.
- [ ] Maps can be premade or generated (generated deferred)
- [ ] Configuring a server

### Milestone 1.3:

Enemies/AI
See [AI](Documentation/main/Systems/AI.md)


### Milestone 1.x:
(not sure where this goes yet; likely will be split later)

Guns and Health. This will be very involved.
See [Guns](Documentation/main/Systems/Gunplay.md)
See [Weapons & Attachments](<Documentation/main/Systems/Weapons & Attachments.md>)
See [Medical](Documentation/main/Systems/Medical.md)
See [Persistence & Death](<Documentation/main/Systems/Persistence & Death.md>)

- [ ] Before anything, getting the base concept of damage, aiming, firing, etc. working.
- [ ] Once working, the specifics of drop, damage, hitscan over time, etc. can be done

## Phase 2: Modding support

**Goal:**

Implementing modding support. This includes adapting existing code/systems to work as their own modules.

**Done when:**

Modules can be added, removed, upgraded, swapped, and overall managed both in the game itself through an internal mod manager and externally.

### Milestone 2.1:

- [ ]

## Phase 3: Optimization

**Goal:**

Barring existing optimizations done during core development, go back through and see if there are ways to improve the game.

This will include an experimental Entity system using DoD principles, cache buffers, double buffering, ring buffers, etc. Previously it included an Event Bus and subscriber/listener system, which can still probably do in the main game, but this one would be hyper optimized.

**Done when:**

### Milestone 3.1:

- [ ]

## Backlog / unsorted

- 
