# Network And FRPG

Use this reference for packet semantics, FRPG message flow, opcode/proto mapping, serializer boundaries, and transport-vs-gameplay separation.

## First Questions

- Is the current question about outgoing, incoming, or shared transport infrastructure?
- Which file or doc is the current single fact source for opcode/proto mapping?
- Is the current hit a transport helper, thin wrapper, serializer/export point, typed producer, or typed consumer?
- What exact chain still is not closed?

## Stable Rules

- Validator switches, length tables, and project packet classes are baseline hints, not final truth.
- Low-level final send is not automatically a gameplay header writer.
- Generic dequeue is not automatically a typed packet consumer.
- Packet length, UI case labels, and enum-looking constants do not prove packet ID.
- A wrapper can be real progress, but only if its caller/owner role is also understood.

## Practical Flow

1. Start from repo-side mapping and docs.
   Read the current packet validators, mapping tables, packet wrappers, and topic docs before binary expansion.
2. Place the current function on the stack of layers.
   Owner/manager -> transport/helper -> wrapper/serializer -> dispatch/consumer -> apply sink.
3. Pick the blocker.
   Use the next anchor that escapes the current generic layer.
4. Take the smallest binary step that answers the blocker.
5. Write back the packet family, current confidence, false leads, and the next jump.

## Common Blockers

- Helper sweep is empty:
  Move away from the helper and into the native demux, switch case, or typed caller.
- Final send is found:
  Trace upward into serializer construction, export object filling, or wrapper ownership.
- Generic dequeue is found:
  Trace upward into the caller that feeds a concrete packet or queue slot.
- Gameplay domain is obvious but transport is open:
  Keep a gameplay note, but do not upgrade it to confirmed packet semantics.

## Canonical Write-Back Targets

- `docs/topics/frpg-message-pipeline.md` for message-chain understanding
- `docs/topics/frpg-proto-mapping.md` for single-source opcode/proto conclusions
- packet-specific reports under `docs/reverse/network-packets/` when the task is already deep and fact-heavy

## False Leads To Record

- Length-only or enum-looking packet guesses
- Strings near packet code with no transport proof
- `.pdata`, vtable, or descriptor neighborhoods with no owner evidence
- Helper layers that are confirmed generic
