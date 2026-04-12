# Party Member Info Headless Runbook

Use this reference when continuing DS3 `PartyMemberInfo` reverse work from a repo-only or headless Ghidra environment, especially when the GUI MCP bridge is unavailable and the current frontier is object recovery, slot semantics, or special-block flow closure.

## Scope

This runbook summarizes one concrete reverse pass around:

- `GetPartyMemberInfo (FUN_140627f20)`
- `PartyMemberInfo` object layout
- `slot[6]` add/remove/state functions
- `special block +0xE0..+0xFC`
- `FUN_1408894b0` category getter

The goal is to keep the next pass from re-opening the same false leads.

## Headless Setup

### Practical constraints

- If the local Ghidra install path contains non-ASCII characters, map it to an ASCII drive letter first.
- Do not run multiple headless jobs against the same project in parallel. Ghidra will lock the project.
- If a headless run times out, clear any stray `java.exe` processes before retrying.
- Use a copied project when the main project is open elsewhere.

### Working command shape

```powershell
subst Z: "C:\path\to\ghidra_12.0.3_PUBLIC"

$env:_JAVA_OPTIONS='-Duser.home=C:\ghidra_userhome'
& 'Z:\support\analyzeHeadless.bat' `
  'C:\ghidra_headless_tmp' 'RE TEST Headless' `
  -readOnly -noanalysis `
  -process 'pc_DarkSoulsIII_runtime.1.15.2.exe' `
  -scriptPath 'C:\Users\Daniel\ghidra_headless_scripts' `
  -postScript DecompileAtAddress.java 0x140627f20
```

### Useful scripts

- `DecompileAtAddress.java`
- `ListCodeRefsToAddress.java`
- `DumpInstructionRange.java`

Prefer this order:

1. direct decompile
2. code refs
3. short instruction slice around the call site

## Recommended Frontier Order

1. Recover pointer-vs-inline ownership first.
2. Split the `slot[6]` array from any adjacent sidecar blocks.
3. Close writers before trusting CT field labels.
4. Use caller assembly to correct decompiler-dropped parameters.
5. Recompute count semantics from writers and gates, not UI names.

## Current Safest Statement

### `GetPartyMemberInfo`

`FUN_140627f20` does **not** return an inline `GameMan + 0xC60` subobject. It returns the qword stored at `GLOBAL_GameMan + 0xC60`:

```text
MOV RAX, [GLOBAL_GameMan]
MOV RAX, [RAX + 0xC60]
RET
```

This means the reverse target is a heap/object pointer owned by `GameMan`, not a fixed in-place struct at `GameMan + 0xC60`.

### `PartyMemberInfo` object

Current broad layout:

```text
PartyMemberInfo
  +0x00  unknown 8-byte head

  +0x08  count(category == 1)
  +0x0C  count(category == 2)
  +0x10  count(category == 0xC)
  +0x14  filtered player-member count
  +0x18  created/live slot count
  +0x1C  effective connected/session total

  +0x20  slot[6], stride 0x1C

  +0xC8  trackedHandleSet[5]
  +0xDC  trackedHandleSetCount

  +0xE0  special block
  +0xFC  dirty flag for +0x14 recompute
```

### `slot[6]`

Current safest slot layout:

```text
slot +0x00  handle
slot +0x04  type
slot +0x08  state
slot +0x0C  event/id-like field A
slot +0x10  event/id-like field B
slot +0x14  float timer
slot +0x18  hidden byte
```

Do **not** reuse the checked-in CT names `initFlag` / `endFlag` as binary truth for this build.

### `FUN_140684d80`

`FUN_140684d80` is the main `slot[6]` add writer.

It writes:

- `slot+0x00 = handle`
- `slot+0x04 = type`
- `slot+0x08 = state`
- `slot+0x0C = param_5`
- `slot+0x10 = param_6`

Observed call-site anchors:

- one caller passes `R9D = 2`, which closes `type==2` as the AI/NPC family
- one caller passes `R9D = 1`, which closes `type==1` as a distinct non-AI family

`type==0` still needs a direct anchor, but it remains the safest broad candidate for the local family.

### `FUN_1406859f0` and `FUN_1406841c0`

These are real `slot[6]` cleanup paths, not the special-block path.

`FUN_1406859f0` proves:

- lookup is by `slot.handle`
- `slot+0x10` is event/id-like, because the AI branch pushes it into `EventFlagMan::SetEventFlag`
- clearing a slot sets:
  - `handle = -1`
  - `slot+0x04 = 1`
  - `slot+0x08 = 0`
  - `slot+0x0C = -1`
  - `slot+0x10 = -1`
  - `slot+0x18 byte = 0`

`FUN_1406841c0` is the bulk AI cleanup scan. It walks all six slots and only processes entries where `slot+0x04 == 2`.

### `FUN_140686590`

`FUN_140686590` is the cleanest anchor for the hidden byte:

- it finds the slot by handle
- it only acts when `slot.type == 1`
- it sets `slot+0x18 = 1`

So the hidden byte is a `type==1` exclusion/soft-ended flag, not a generic end flag for every slot family.

### `FUN_1406866a0`

`FUN_1406866a0` serializes `type==2` slots into packet `0x32`.

It proves:

- `slot+0x0C` and `slot+0x10` are payload fields, not booleans
- the runtime category code comes from `FUN_1408894b0`
- the payload also includes world position and one additional runtime-derived dword

### `FUN_1406861d0`

`FUN_1406861d0` is **not** the normal `slot[6]` add writer.

Caller closure:

- only direct caller: `FUN_1404727a0`
- its caller: `FUN_1408c2c20`
- instruction slice at the call site shows:

```text
CALL 140627f20
MOV  RDX, RDI
MOV  RCX, RAX
CALL 1406861d0
```

So the real call is:

- `RCX = PartyMemberInfo*`
- `RDX = sourceRecord*`

This function writes the **special block** at `+0xE0..+0xF8`, not the six slots.

Current broad semantics:

```text
+0xE0  special state (1 -> active, 2 -> consumed)
+0xE4  entity id
+0xE8  eventFlagId-like
+0xEC  display/target entity id family
+0xF0  source record field
+0xF4  variant code (-18 / -19)
+0xF8  source byte flag
+0xFC  dirty flag used by +0x14 recompute
```

### `FUN_14046ecc0`

`FUN_14046ecc0` is the source-record selector for the special block path.

Current safest statement:

- it scans current-map `MsbResCap` entries of subtype `0xC`
- it chooses entries whose linked resource family reports `type == 2`
- it filters by distance from the main player using a radius test
- it returns `entry + 0x20`, which is the source record consumed by `FUN_1406861d0`

The record is therefore a nearby, map-authored special-event source object, not a live slot record from `PartyMemberInfo`.

### `FUN_1408894b0`

`FUN_1408894b0` is only a getter:

```c
*param_2 = *(int *)(param_1 + 0x70);
return param_2;
```

It does not compute the category code. It only reads a pre-existing runtime field.

## Count Semantics

### Stable

- `+0x08 / +0x0C / +0x10`
  - recomputed by `FUN_140687760`
  - keyed by runtime category codes `1 / 2 / 0xC`

- `+0x18`
  - recomputed by `FUN_140687760`
  - increments only when a non-empty slot resolves to a real runtime object
  - safest broad name: `created/live slot count`

- `+0x1C`
  - recomputed by `FUN_1406868a0`
  - equals:
    - `trackedHandleSetCount (+0xDC)`
    - `+ 1` if the special block is active
    - `+ max(1, sessionCount)`
  - safest broad name: `effective connected/session total`

### Not fully closed

- `+0x14`
  - recomputed by `FUN_1406875f0` when `+0xFC` is dirty
  - counts only a filtered subset of slot families
  - do not name it from the CT label yet

## Direct Anchors

- `FUN_140627f20`: `PartyMemberInfo*` is read from `GameMan + 0xC60`
- `FUN_140684d80`: main `slot[6]` add writer
- `FUN_1406859f0`: single-slot cleanup and compaction
- `FUN_1406841c0`: bulk AI cleanup
- `FUN_140686590`: hidden byte writer at `slot+0x18`
- `FUN_1406866a0`: AI payload serializer
- `FUN_1406861d0`: special block writer
- `FUN_14046ecc0`: special source-record selector
- `FUN_140687760`: category counts and `+0x18` recompute
- `FUN_1406875f0`: `+0x14` recompute
- `FUN_1406868a0`: slot state machine plus `+0x1C` recompute
- `FUN_14078b830`: session-count provider from `SprjSessionManager`
- `FUN_1408894b0`: runtime category getter at `obj + 0x70`

## False Leads Ruled Out

- `GetPartyMemberInfo` returns an inline `GameMan + 0xC60` subobject
- `FUN_1406861d0` is the normal slot add path
- `FUN_1408894b0` computes a classification instead of reading one
- checked-in CT `Party Member Info` field names are exact binary truth for this build
- `slot+0x14` and `slot+0x18` are generic boolean flags

## Next Anchors

1. Recover the exact business semantics of the special source record returned by `FUN_14046ecc0`.
   Focus on fields `[1] / [3] / [4] / [5] / [6]`.
2. Close the remaining slot family caller chain.
   Follow the remaining callers of `FUN_140684d80` until `type==0` is directly anchored.
3. Close `+0x14`.
   Follow `+0xFC` writers and `FUN_1406875f0` callers to stabilize the user-facing meaning of this filtered count.
4. Keep CT labels at `CODE_ALIAS` level until they are backed by one of the writers above.
