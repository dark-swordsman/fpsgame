---
updated: 2026-06-20
covers:
  - experiments/gunplay-slice/**
---

# Gunplay

## Recoil Design

Somewhere in the ballpark of Tarkov, STALKER, and Counter-Strike — to be refined through iteration.

## Hipfire vs ADS

- Hipfire is usable and predictable at close range (~10-20m)
- ADS provides meaningful accuracy improvement at range
- Neither is dominant in all situations

### Spread model — gun offset, not bullet jitter

The bullet **always** leaves straight down the muzzle. Its only intrinsic dispersion is
the gun's mechanical accuracy, an **MOA** weapon stat (`accuracy_moa`) applied as a tiny
cone at the muzzle. "Spread" in the gameplay sense (hipfire loose, ADS tight) is modelled
as a **per-shot whole-gun kick**: firing shoves the gun off-aim within the hip/ADS cone
(`spread_hip_deg` / `spread_ads_deg`), and because the bullet follows the barrel the shot
goes where the gun is now pointing — the visible gun never lies. The kick lives in its own
viewmodel channel and settles back via `spread_recovery`; sustained fire blooms as kicks
stack faster than they recover.

## Ballistics

Time-delayed hitscan approach:
- Start with hitscan as the base layer, augment toward physics behavior rather than building pure physics from scratch
- On fire: calculate the bullet path immediately (hitscan), accounting for bullet drop
- Resolve the hit after a travel-time delay based on velocity and distance
- At resolution time, re-check whether the target is still in the path — if they moved out of it during travel, it misses
- Effect: close range feels instant; at range, bullet travel time becomes a real factor (targets can move out of the way, or into it)
- Keeps network complexity low while producing authentic ballistics feel

## Ammo System

Calibers (planned):
- 20mm Vulcan, 14.5x114, 12.7mm (.50 cal)
- 10mm, 9x19, 9x39
- 8.6x70 (.338 Lapua)
- 7.62x54R, 7.62x51 (.308), 7.62x39
- 5.7mm, 5.56x45, 5.45x39
- .45 ACP, .380 ACP

Ammo properties per round:
- **Caliber** — base category
- **Type** — FMJ, Hollow Point, AP, Dum-Dum
- **Armor penetration**
- **Velocity** — determines travel-time delay and drop; modified by barrel length / suppressors
- **Damage**

Dynamic compatibility mode: option for simpler servers to collapse calibers into categories (pistol, rifle, etc.)

## Magazines

- Capacity
- Reload speed modifier
- Jam chance

## Attachments

Rail systems: Dovetail, Picatinny
See [[Weapons & Attachments]]
