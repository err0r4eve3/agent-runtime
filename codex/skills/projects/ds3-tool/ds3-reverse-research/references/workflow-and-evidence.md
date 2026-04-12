# Workflow And Evidence

Use this reference first whenever the task is mainly about process, naming, evidence strength, or writing findings back.

## Core Principles

- Define the question before naming the thing.
- Separate `project interpretation` from `binary truth`.
- Prefer the narrowest safe wording over a guessed final name.
- Treat negative evidence as evidence.
- Express every blocker as a concrete next jump, next owner, or next evidence type.
- Let multiple readers collect evidence if needed, but keep one canonical writer.

## Standard Flow

1. Freeze the question and output surface.
   Write the smallest problem, the canonical docs, and the proof of progress for this round.
2. Build a repo baseline.
   Start from source, existing docs, validators, wrappers, managers, and plans before binary exploration.
3. Draw the runtime layers.
   Common layers are owner/manager, transport or generic helper, thin wrapper/serializer, dispatch/consumer, and apply sink.
4. Choose the current `frontier`.
   Do not "scan everything"; route off the specific blocker.
5. Take minimum binary evidence.
   Direct decompile first, then caller/xref confirmation, then assembly or graph work only when required.
6. Record false leads explicitly.
   If a path is empty, generic, or mismatched, write it down.
7. Decide the naming action from evidence strength.
8. Write back to canonical docs and perform a consistency check.

## Evidence Levels

| Level | Meaning | Naming action |
| --- | --- | --- |
| `CODE_ALIAS` | Only project names, comments, tables, or external labels | Keep alias or `Unknown` |
| `BINARY_ANCHOR` | One stable native anchor such as string, RTTI, vtable, owner, or field | Strengthen notes, but do not overname |
| `FLOW_EVIDENCE` | One meaningful stage of send, receive, dispatch, apply, or production is closed | Narrow to family-level semantics |
| `BROAD_SEMANTIC` | Functional area is stable but official name is not | Use a conservative broad name |
| `CONFIRMED` | Owner, role, and core flow are basically closed | Use the current confirmed name |
| `FALSE_LEAD` | Evidence shows the path is not the target | Record why it is false and stop re-chasing it |

## Common Frontier Switches

- Fixed-id helper has no callers: move upward to demux, typed consumer, or owner.
- Final send is found but packet meaning is not: move upward to serializer or export boundary.
- Generic dequeue is found but typed caller is not: move upward to the concrete producer.
- Gameplay semantics are strong but transport is open: keep alias-only or `unconfirmed`.
- Wrapper pair is stable but official name is not: close with a broad semantic family or `Unknown` plus notes.

## Write-Back Contract

Every canonical update should answer:

- What is the safest current statement?
- Which direct anchors support it?
- Which false leads were ruled out?
- What is the blocker?
- What is the next anchor?

If ledgers, trees, or queues exist for the task, keep their `current_name`, blocker, and next anchor aligned with the deep report.

## Anti-Patterns

- Naming from one string or table entry
- Treating transport helpers as gameplay consumers
- Writing "continue analysis" with no concrete next jump
- Leaving false leads undocumented
- Updating one canonical doc while leaving the related queue or ledger stale
