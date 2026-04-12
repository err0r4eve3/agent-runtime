# Field62 Process And Findings

Use this reference when continuing `field 62 / anticheat_data` reverse work or when checking whether a new claim is stronger than the current evidence.

## Scope

This process summary is for the specific DS3 path:

- protobuf `PlayerStatus.anticheat_data = field 62`
- native sink `PlayerStatus + 0x140/+0x148`
- source vector `source + 0x258`
- staging family around `0x144E0228D` and `0x144E715A4`

It is not a generic anti-cheat guide.

## Number-Space Contract

Keep these domains separate every time:

- `field 62`: protobuf `PlayerStatus.anticheat_data`
- `slot 0x62`: upload slot / dirty-bit index inside `PlayerStatusSyncManager`
- `0x3F6`: source status ID
- `0x1770 / 0x1771`: UI/help-text constants

If two numbers look similar, that is not evidence they are the same path.

## Reverse Flow Used In This Pass

1. Close the sink first.
   Prove the native storage and append helper before naming any producer.
2. Close the source vector boundary.
   For `field 62`, this was `source + 0x258/+0x260/+0x268/+0x270`.
3. Close the staging sandwich.
   Use both the single-value staging writer and the pair reader.
4. Only then inspect wrapper families.
   If a value enters staging as a literal constant, downgrade semantics immediately.
5. Use dearxan-clean only as a family hint.
   It can prove "this constant enters the same family" but not "this RVA equals the same current-dump object".
6. Write back false leads, not only positive findings.

## Closed Anchors

- `0x141B34D60` appends into `PlayerStatus + 0x140`
- `0x141B32B4B` is the key append call site on the `field 62` sink side
- `source + 0x258` is the repeated-int source vector used by the `slot 0x3C -> field 62` path
- `0x144E0228D` is the current best `single-value staging writer`
- `0x144E715A4` is the current best `staging pair reader`

## What Was Ruled Out

- `0x1770` is not currently proven as a native `field 62` sink write point
- the two known `mov edx, 0x1770` sites are UI/help-text consumers
- `slot 0x62` is not the same numbering space as protobuf `field 62`
- several "looks-like-player-stat" interpretations for `field 62` values were withdrawn
- direct RVA translation from dearxan-clean families into the current dump caused one major address error and must not be repeated

## Current Safest Semantic Statement

`field 62` is best described as a `mixed code/signature vector`.

Current evidence supports:

- at least a large subset of entries are branch-selected fixed integers
- those integers are uploaded as raw ints after passing through the same staging family
- current evidence does not support naming them as direct `souls`, `poise`, `item_discovery`, `attack_power`, or single gameplay-stat mirrors

## Fixed-Code Family Already Observed

These entries are currently safest to treat as `hardcoded code/signature entries`, not named gameplay stats:

- `1`
- `791`
- `890`
- `990`
- `999`
- `2703`
- `2800`
- `3700`
- `10710`
- `80990`
- `100700`
- `990900`
- `5000890`

These remain unresolved:

- `0`
- `50`
- `9010`
- `15000`
- `16000`

For `15000 / 16000`, current evidence only closes them to another helper family, not the confirmed `field 62` staging family.

## Dearxan-Clean Reference Rule

Use the local `DarkSoulsIII-post-dearxan-clean-for-ghidra.dump` only to answer:

- does this integer appear as a wrapper constant?
- does it converge into the same helper family?

Do not use it alone to answer:

- what current-dump address owns the logic?
- what exact object/class owns the current path?
- what concrete gameplay semantic each code means?

## Current `0x1770` Boundary

Known current-dump `0x1770` immediate sites:

- `0x1406E14C0` / `0x1406E154B`
- `0x1406EC5E0` / `0x1406EC678`

Current safest meaning:

- both are UI/help-text writes
- neither is currently proven as a `field 62` native producer

There is also a non-UI `mov ecx, 0x1770` hit in the reference dump, but it has not been proven to enter the confirmed `field 62` staging family in the current dump.

## Next Anchors

- reverse xrefs into `0x144E0228D`
- reverse xrefs into `0x144E715A4`
- isolate unresolved entries `0 / 50 / 9010`
- only revisit `0x1770` if it can be shown entering the confirmed staging family, not just another helper family

## Canonical Write-Back

When this line of work advances, update:

- `docs/reverse/anti-cheat/ban_info_summary.md`

Each update should include:

- current safest statement
- direct evidence
- false leads ruled out
- current blocker
- next anchor
