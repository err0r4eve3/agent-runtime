---
name: ds3-reverse-research
description: Use when working on DS3-Tool reverse-engineering tasks backed by binary or runtime evidence, especially packet semantics, FRPG/proto mapping, anti-cheat or status-upload paths, runtime object recovery, gameplay structure analysis, hook timing, or when new findings must be written back to canonical reverse docs.
---

# DS3 Reverse Research

## Overview

This skill turns the repo's reverse notes into one reusable DS3-Tool workflow. Use it to choose the next `frontier`, keep names tied to evidence strength, and write findings back without mixing project aliases with binary truth.

## Repo Quick Reference

- Start every DS3-Tools reverse task at `docs/reverse/README.md`.
- Read `docs/reverse/source-files.md` early so code, wrappers, and docs stay aligned.
- For unresolved naming, owner recovery, hook points, or verification debt, open `docs/reverse/runtime-addresses/address_tree_verification_queue.md` and classify the next step as `doc-first`, `ghidra-first`, or `pending`.
- Keep active canon and history separate:
  - active facts live under `docs/reverse/` and `docs/topics/`
  - historical context lives under `docs/reverse/archive/` and legacy `plans/`
- Packet / FRPG system of record is:
  - `docs/reverse/network-packets/network_packets_architecture.md`
  - `docs/reverse/network-packets/by-id/packet-001-076-index.md`
  - `docs/reverse/network-packets/by-id/packet-001-076-semantic-ledger.md`
  - `docs/reverse/runtime-addresses/address_tree_ds3proxy_network_packets.md`
  - `docs/reverse/runtime-addresses/address_tree_verification_queue.md`
  - `docs/reverse/network-packets/frpgmessage_analysis.md`

## Load The Right Reference

- Read `docs/reverse/README.md` first for the active repo entrypoint, evidence priority, and system-of-record map.
- Read [references/workflow-and-evidence.md](references/workflow-and-evidence.md) first for the core SOP, evidence levels, naming rules, and write-back contract.
- Read [references/network-and-frpg.md](references/network-and-frpg.md) for FRPG, packet, opcode/proto, serializer, and transport questions.
- Read [references/anti-cheat-and-status.md](references/anti-cheat-and-status.md) for anti-cheat, status upload, telemetry, `field 62`, number-space hygiene, and ban-path analysis.
- Read [references/runtime-objects-and-structures.md](references/runtime-objects-and-structures.md) for player runtime objects, gameplay structures, bullet/item-drop modeling, and wrapper-vs-owner recovery.
- Read [references/startup-hooking-and-stability.md](references/startup-hooking-and-stability.md) for `AfterMain`, `SteamAPI_Init`, `AllocatorHook`, `dearxan`, startup races, and crash-sensitive hook timing.

## Core Workflow

1. Freeze the smallest question before touching Ghidra.
   State the current problem, the canonical output docs, and the condition that proves this round made progress.
2. Build the repo baseline first.
   Read `docs/reverse/README.md`, `docs/reverse/source-files.md`, the relevant stable docs, and the queue before trusting archive notes or binary guesses.
3. Pick one `frontier`.
   Classify the blocker by layer and by `doc-first` / `ghidra-first` / `pending` instead of sweeping the whole graph again.
4. Take minimum binary evidence.
   Prefer direct decompile, then caller/xref confirmation, then assembly or graph expansion only if the current blocker requires it.
5. Bind names to evidence strength.
   If the chain is not closed, keep `Unknown`, alias-only, or a broad semantic family.
6. Write back immediately.
   Record the safest current statement, direct evidence, false leads, blocker, and next anchor in every canonical surface that changed.

## Repo Write-Back Matrix

- packet verdict, confidence, or naming change -> `packet-001-076-semantic-ledger.md`
- unresolved blocker, next anchor, or verification debt -> `address_tree_verification_queue.md`
- address roots, hook points, owner chains, or layouts -> the relevant `docs/reverse/runtime-addresses/*.md`
- reusable subsystem summary -> `docs/topics/*.md`
- fact-heavy packet or system closure -> dedicated report under `docs/reverse/`

If a packet / FRPG / runtime finding changes more than one surface, update them together. Do not land a deep report while leaving the ledger, address tree, or verification queue stale.

## Output Contract

Every reverse update should leave behind these five things:

- `current safest statement`
- `direct evidence`
- `false leads ruled out`
- `current blocker`
- `next anchor`

If you cannot fill those fields, the current pass is probably still too vague.

## Hard Rules

- `project interpretation` is not `binary truth`.
- A string, table, enum, UI constant, or existing alias is not enough to overname a symbol.
- Generic helpers, shell wrappers, continuations, and low-level send paths are not business semantics by default.
- Negative evidence must be written down, not kept in memory.
- Canonical docs should have one writer closing the loop, even if evidence collection was parallelized elsewhere.
- `plans/` is historical context unless the task is explicitly extending a legacy plan series.

## Canonical Targets

Prefer writing conclusions back into the smallest stable target:

- `docs/reverse/` for fact-heavy deep reports
- `docs/topics/` for reusable topic summaries
- ledgers and trees for current canonical reverse facts
- queues for unresolved blockers and next anchors
- legacy `plans/` only when the task is explicitly extending that historical series

## Anti-Patterns

- Re-scanning the same helper layer after it is already proven generic
- Renaming from one anchor without owner or flow evidence
- Mixing numbering spaces in anti-cheat or packet work
- Treating startup timing bugs as ordinary downstream feature bugs
- Updating only a deep report while leaving the related ledger, tree, or queue stale
- Treating `plans/` or project-side tables as the current canonical truth
- Ending with "continue analysis" instead of a concrete blocker and next jump
