# Idea: Navigable Architecture Map

**Status:** Idea — not started  
**Date noted:** 2026-06-01

---

## The Goal

A visual, layered map of the entire software stack — similar to how Linux documentation shows
kernel → OS → distro layers — so that anyone (developer, mod author, future collaborator) can
orient themselves in the codebase at a glance and drill down into what they need.

"Navigable" means: not just a static image, but something you can zoom, click, and follow into
deeper detail.

---

## Proposed Layer Structure

The game already has a natural layered architecture:

```
┌─────────────────────────────────────────────┐
│  Layer 5 — Game Content                     │
│  Mods · Maps · Species · Items · Weapons    │
├─────────────────────────────────────────────┤
│  Layer 4 — Game Systems                     │
│  AI · Gunplay · Inventory · Medical         │
│  World & Weather · Weapons & Attachments    │
├─────────────────────────────────────────────┤
│  Layer 3 — Platform Services                │
│  ModAPI · StateSystem · DomainBus           │
│  ContentRegistry                            │
├─────────────────────────────────────────────┤
│  Layer 2 — GDExtension (C++)                │
│  Entity pools · Execution groups            │
│  Processor registry · Threading             │
├─────────────────────────────────────────────┤
│  Layer 1 — Engine                           │
│  Godot 4.6 · Jolt Physics · Forward+ Vulkan │
├─────────────────────────────────────────────┤
│  Layer 0 — Hardware / OS                    │
│  CPU cores · GPU · Windows 11               │
└─────────────────────────────────────────────┘
```

Each layer only depends on layers below it. A mod author works in Layer 5 and touches Layer 3
APIs. A core game system developer works in Layer 4. A GDExtension developer works in Layer 2.

---

## Tool Options

### Option A — Obsidian Canvas (recommended, already in our toolchain)

Obsidian has a built-in **Canvas** feature (`.canvas` files) — an infinite whiteboard where you
place cards, embed notes, draw connections, and navigate between them. Cards can embed full
markdown notes, so each layer/system node on the canvas could link directly to its spec or
implementation doc.

This is navigable inside Obsidian: zoom, pan, click a system card → opens the spec. It's also
version-controlled (`.canvas` is JSON). No external tools needed — we already use Obsidian.

**What it would look like:** A canvas with six horizontal bands (the layers above). Each band
contains system cards. Cards have links to their docs. Connections show dependencies.

### Option B — Mermaid diagram (simpler, already used)

We already use `.mermaid` files embedded in Obsidian (see `Systems/mod-architecture.mermaid`).
A more elaborate flowchart or `graph TD` could show the full stack. Not interactive, but readable
and version-controlled. Good as a supplement to Option A.

### Option C — Interactive HTML (most powerful, more effort)

A D3.js or Mermaid-live style HTML page — zoomable, clickable nodes that open docs. Could be
exported from the Obsidian vault or generated from a data file. Overkill for now, but worth
noting as the ceiling if the map becomes a public-facing resource (mod author docs, etc.).

---

## Recommendation When We Build This

Start with **Obsidian Canvas**. It requires no new tooling, is navigable, and lives next to the
docs it links to. Build it incrementally — one layer at a time as systems are specced and
implemented. A Mermaid overview diagram alongside it gives a quick static reference for docs
and the README.

Export to HTML (Option C) only if the map becomes part of public mod author documentation.

---

## Related

- [[codebase-map]] — current text-based layout of the repo
- [[mod-author-guide]] — mod author entry point (would be linked from the canvas)
- [[2026-05-22-fps-game-design]] — full design spec
