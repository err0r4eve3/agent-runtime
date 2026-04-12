# Paramdex Param Struct Reconstruction

Use this reference when the task is to align `gameParams.hpp` style structs with DS3 Paramdex without breaking existing DS3-Tool call sites.

## Goal

The target is not "rename everything to Paramdex names". The target is:

- recover missing fields and correct sizes from Paramdex
- preserve binary layout
- preserve old field names where DS3-Tool code already depends on them
- leave behind compile-time and runtime checks that catch future drift

## Standard Flow

1. Freeze the scope before editing.
   Decide which structs are in play, which files consume them, and whether the task is structural completion, semantic renaming, or both.
2. Build a code-side baseline first.
   Read the current `DS3-Proxy/include/game/gameParams.hpp`, then search for every struct's live uses in `src/`, `include/`, and tests before trusting Paramdex names.
3. Split structs into two buckets.
   Compatibility-sensitive structs stay manual.
   Mostly passive data structs can be generated directly from Paramdex.
4. Compare Paramdex against the current header at the level of offset, width, signedness, and packing.
   Do not stop at field names. Check `float` vs `int32_t`, `uint8_t` vs `int8_t`, grouped bitfields, and tail padding.
5. Reconstruct the safest layout.
   For compatibility-sensitive structs, keep old public names alive with unions or compatibility aliases.
   For passive structs, prefer a generated packed header plus `static_assert(sizeof(...))`.
6. Add validation immediately.
   Put `static_assert(sizeof(...))` and key `offsetof(...)` checks near the structs or in tests.
   Then compile the main project, compile the test project, and run the test executable.

## Bucket Rule

Keep a struct manual if any of these are true:

- UI or gameplay code already reads its old field names directly
- helper code depends on legacy aliases
- a small name change would fan out into many unrelated edits
- the struct already mixes CT-era names, project names, and partial Paramdex recovery

Generate or rewrite more aggressively if:

- the struct is mostly a passive data layout
- the repo barely references it outside `gameParams.hpp`
- the main risk is missing fields or wrong packing, not name compatibility

## What Worked In This Pass

This round separated the structs like this:

- manual compatibility structs: `Bullet`, `LockCamParam`, `MapMimicryEstablishmentParam`, `NetworkParam`
- Paramdex-derived structs: `AttackParam_PC`, `BehaviorParam_PC`, `BonfireWarpParam`, `EquipParamGoods`, `EquipParamProtector`, `EquipParamWeapon`, `LodParam`, `Magic`, `NpcParam`, `ObjActParam`, `ObjectParam`, `SpEffectParam`, `SpEffectVfxParam`, `SwordArtsParam`, `ThrowParam`, `UpperArmParam`, `WetAspectParam`

That split kept existing UI/helper code stable while still recovering missing Paramdex coverage.

## Paramdex-Specific Checks

When translating XML definitions into C++ structs, explicitly verify:

- packed layout expectations
- bitfield grouping by storage width, not only by XML token spelling
- duplicated semantic fields that appear as repeated slots in legacy headers
- tail padding needed to hit the Paramdex-reported size
- comments and offset annotations after the final type widths are fixed

## Common Failure Modes

- Replacing a live legacy struct with pure Paramdex names and breaking UI code.
- Matching names but missing the real storage type, causing silent offset drift.
- Treating `dummy8` and `u8` as different bitfield storage groups when they share one byte.
- Fixing a field in the middle but forgetting to re-check the tail of the struct.
- Trusting header comments after a type change instead of recomputing offsets.

## Validation Contract

Do not call the reconstruction done until all three pass:

- main project compiles
- test project compiles
- `DS3-Proxy.Tests.exe` runs cleanly

Preferred checks for this repo:

- `sizeof(struct)` for every recovered struct
- `offsetof(...)` for the fields DS3-Tool actively touches
- one behavioral regression test for any helper that writes or patches the recovered struct

## Output Contract

A good Paramdex reconstruction pass should leave behind:

- the reconstructed structs
- a note explaining which structs stayed manual and why
- size and offset guards
- build evidence
- test evidence

If those five things are not present, the next person will have to reverse the reconstruction again instead of building on it.
