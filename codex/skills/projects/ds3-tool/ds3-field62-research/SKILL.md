---
name: ds3-field62-research
description: Use when tracing Dark Souls III `field 62 / anticheat_data`, separating it from UI `0x1770/0x1771`, validating producer and staging chains, or cross-checking current dumps against dearxan-clean reference dumps without collapsing numbering spaces.
---

# DS3 Field62 Research

## Overview

This skill is the repo-local SOP for `field 62 / anticheat_data` work. Use it when the task is specifically about the `PlayerStatus` repeated-int path, `0x1770`, upload-slot confusion, or constant-wrapper families.

Read [references/process-and-findings.md](references/process-and-findings.md) first.

## When To Use

- `field 62 / anticheat_data` producer or sink tracing
- `slot 0x62` vs `field 62` vs `0x3F6` vs `0x1770` confusion
- `0x144E0228D` / `0x144E715A4` staging-family work
- current dump vs dearxan-clean reference dump cross-checks
- tasks that need canonical write-back into anti-cheat docs

Do not use this skill for generic FRPG, startup-hook, or unrelated gameplay-object recovery.

## Core Rules

- Keep number spaces separate: protobuf `field 62`, upload `slot 0x62`, source status ID `0x3F6`, UI/help-text `0x1770/0x1771`.
- Close the sink before naming the producer.
- Use a writer/reader sandwich: sink append side, source vector side, staging writer/reader side.
- Treat dearxan-clean as `reference-only`. Do not blindly translate RVA families into the current dump.
- If a value is only proven to be a branch-selected integer, call it `code/signature entry`, not a gameplay stat.
- Record false leads explicitly in canonical docs.

## Stable Anchors

- `PlayerStatus + 0x140/+0x148` = native sink for protobuf `field 62`
- `0x141B34D60` = append helper into `PlayerStatus + 0x140`
- `source + 0x258/+0x260/+0x268/+0x270` = source vector quartet for the `slot 0x3C -> field 62` path
- `0x144E0228D` = single-value staging writer
- `0x144E715A4` = staging pair reader

## Hard Conclusions From This Pass

- The only currently confirmed `0x1770` immediate write sites are UI/help-text consumers, not confirmed `field 62` writers.
- A large subset of observed `field 62` entries are branch-selected fixed integers that enter the same staging family.
- Current safest wording for `field 62` is `mixed code/signature vector`, not `direct live status mirror`.

## Write-Back Targets

- Deep facts: `docs/reverse/anti-cheat/ban_info_summary.md`
- Reusable workflow/process: this skill and its reference file

