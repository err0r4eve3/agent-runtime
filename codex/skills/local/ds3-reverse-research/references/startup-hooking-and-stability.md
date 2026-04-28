# Startup Hooking And Stability

Use this reference for startup timing, hook installation order, `AfterMain`, `SteamAPI_Init`, `AllocatorHook`, `dearxan`, and crash-sensitive runtime bring-up.

## Triage Order

1. Confirm whether the critical call already happened before the hook was installed.
2. Confirm whether the runtime readiness gate is ever reached.
3. Confirm whether hook ordering or anti-tamper neutralization changes allocator or startup behavior.
4. Only then debug downstream feature code.

## DS3-Tools Repo Surfaces

- `docs/topics/startup-stability.md`
- `docs/topics/steam-init-race.md`
- `docs/topics/allocator-hook.md`
- `docs/topics/dearxan-disabler.md`
- `docs/topics/crash-safety.md`
- `docs/reverse/dearxan/address_tree_dearxan.md`
- `docs/reverse/runtime-addresses/address_tree_ds3proxy_runtime_game.md`
- `docs/reverse/runtime-addresses/address_tree_verification_queue.md`

If a startup hook missed the real call, downstream systems may look broken even though they never had a chance to initialize.

## Stable Rules

- `SteamAPI_Init` timing bugs are startup-order bugs first, not ordinary feature bugs.
- `AfterMain` and similar callbacks should be analyzed against the true startup timeline, not against desired architecture alone.
- `AllocatorHook` behavior must be read together with `dearxan` or Arxan-neutralization timing.
- Crash-safety is part of reverse bring-up: lifetime, nullability, bounds, and races matter as much as hook placement.

## Common Failure Modes

- Hook installed after the real one-shot call already returned
- Readiness gate never opens, so later systems never run
- Hook fires too early, before dependent runtime state is valid
- Anti-tamper or allocator changes shift startup order or object lifetime
- Downstream crashes caused by stale assumptions about initialization order

## Practical Workflow

1. Draw the startup timeline with concrete hook points.
2. Mark one-shot calls and readiness gates.
3. Identify which missed or early event explains the observed symptom.
4. Confirm the minimal binary or runtime anchor for that event.
5. Write back the timing relationship, not only the symptom.

## Canonical Targets

- `docs/topics/startup-stability.md`
- `docs/topics/steam-init-race.md`
- `docs/topics/allocator-hook.md`
- `docs/topics/dearxan-disabler.md`
- `docs/topics/crash-safety.md`

## Write-Back Fields

- observed symptom
- missed or early event
- current timing explanation
- direct anchor
- next verification point
- sync any changed topic summary, address tree, and verification-queue notes in the same pass
