# Anti-Cheat And Status

Use this reference for anti-cheat, status upload, telemetry, `field 62`, ban-path analysis, and any task where multiple numbering spaces look deceptively similar.

## Keep These Domains Separate

- anti-cheat UI or help-text sinks
- anti-cheat data production
- status upload control masks and slots
- source status IDs
- incoming penalty or push handling

## DS3-Tools Repo Surfaces

- `docs/reverse/anti-cheat/ban_info_summary.md`
- `docs/topics/anti-ban-and-status.md`
- `docs/reverse/network-packets/frpgmessage_analysis.md` when anti-cheat or status work crosses FRPG / protobuf
- `docs/reverse/runtime-addresses/address_tree_ds3proxy_runtime_game.md` for offsets, owners, and hook points
- `docs/reverse/dearxan/address_tree_dearxan.md` for dearxan / SteamStub / anti-tamper handoff work
- `docs/reverse/runtime-addresses/address_tree_verification_queue.md` for unresolved blockers and next anchors

If two constants share the same number, that does not make them the same domain.

## Number-Space Hygiene

Write each number with its role, not only its value.

- UI/help-text constants are not protobuf fields.
- Protobuf fields are not local getter slots.
- Getter slots are not upload bitset positions.
- Upload bitset positions are not source status IDs.

When documenting a path, keep the number space attached to the node name so later notes do not collapse them together.

## Practical Rules

- Use `frontier-driven tracing`: once a helper or continuation is proven shell-like, move to the typed caller, owner, writer, or consumer.
- Use `writer/reader sandwich` for data paths such as `field 62`: trace from read side and write side until both stop points are clear.
- Use `evidence-level naming`: alias until you have stable binary anchors; confirmed semantics require a mostly closed producer -> data -> rule -> consumer chain.
- Use `static/dynamic split`: static analysis owns the conclusion; runtime checks only validate address identity, timing, or one concrete stop point.
- Use external names as side evidence only. CT, DSMapStudio, Paramdex, and project comments cannot upgrade confidence alone.

## Typical False Leads

- Treating UI/help constants as anti-cheat producers
- Collapsing `field 62` and slot `0x62` into one path
- Naming a runtime-filled sink as a real owner with no writer, RTTI, or ctor evidence
- Declaring a live incoming parser when the path only closes to local replay or command bridging

## Evidence Priority

Use this order when sources disagree:

1. Ghidra static anchors
2. Dynamic runtime validation
3. Repo source, logger output, tests
4. External naming tables or community references

## Write-Back Checklist

- Separate every numbering space explicitly
- State the current producer, checked data, rule, and consumer if known
- Record the exact stop point when the chain is still open
- Record the false leads that were ruled out so the same helper layer is not scanned again
- Sync the anti-cheat/status summary, relevant address-tree surfaces, and queue notes together when the conclusion changes more than one repo surface
