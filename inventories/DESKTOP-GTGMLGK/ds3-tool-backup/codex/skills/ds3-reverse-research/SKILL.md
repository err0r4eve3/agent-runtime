---
name: ds3-reverse-research
description: Use when working on DS3-Tool reverse-engineering tasks backed by binary or runtime evidence, especially packet semantics, FRPG/proto mapping, anti-cheat or status-upload paths, runtime object recovery, gameplay structure analysis, hook timing, or when new findings must be written back to canonical reverse docs.
---

# DS3 Reverse Research

## Overview

This skill turns the repo's reverse notes into one reusable DS3-Tool workflow. Use it to choose the next `frontier`, keep names tied to evidence strength, and write findings back without mixing project aliases with binary truth.

## Load The Right Reference

- Read [references/workflow-and-evidence.md](references/workflow-and-evidence.md) first for the core SOP, evidence levels, naming rules, and write-back contract.
- Read [references/network-and-frpg.md](references/network-and-frpg.md) for FRPG, packet, opcode/proto, serializer, and transport questions.
- Read [references/anti-cheat-and-status.md](references/anti-cheat-and-status.md) for anti-cheat, status upload, telemetry, `field 62`, number-space hygiene, and ban-path analysis.
- Read [references/runtime-objects-and-structures.md](references/runtime-objects-and-structures.md) for player runtime objects, gameplay structures, bullet/item-drop modeling, and wrapper-vs-owner recovery.
- Read [references/startup-hooking-and-stability.md](references/startup-hooking-and-stability.md) for `AfterMain`, `SteamAPI_Init`, `AllocatorHook`, `dearxan`, startup races, and crash-sensitive hook timing.

## Core Workflow

1. Freeze the smallest question before touching Ghidra.
   State the current problem, the canonical output docs, and the condition that proves this round made progress.
2. Build the repo baseline first.
   Read the relevant code, `docs/topics/`, `docs/reverse/`, and existing plans before trusting binary guesses.
3. Pick one `frontier`.
   Classify the blocker by layer instead of sweeping the whole graph again.
4. Take minimum binary evidence.
   Prefer direct decompile, then caller/xref confirmation, then assembly or graph expansion only if the current blocker requires it.
5. Bind names to evidence strength.
   If the chain is not closed, keep `Unknown`, alias-only, or a broad semantic family.
6. Write back immediately.
   Record the safest current statement, direct evidence, false leads, blocker, and next anchor in the canonical docs.

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

## Canonical Targets

Prefer writing conclusions back into the smallest stable target:

- `docs/reverse/` for fact-heavy deep reports
- `docs/topics/` for reusable topic summaries
- ledgers, trees, queues, or plans when the current task already uses them as the active canonical surface

## Anti-Patterns

- Re-scanning the same helper layer after it is already proven generic
- Renaming from one anchor without owner or flow evidence
- Mixing numbering spaces in anti-cheat or packet work
- Treating startup timing bugs as ordinary downstream feature bugs
- Ending with "continue analysis" instead of a concrete blocker and next jump
