# Packet Attack Surface And Defense

Use this reference when the task is mainly about inbound packet attack-surface review, validator hardening, or deciding whether a DS3 packet family should be `allow`, `drop`, `observe`, or `research-frontier`.

## Scope Freeze

- Freeze the packet range first. For this workflow, the working scope was inbound gameplay packets `1..76`.
- Freeze the false-positive budget. Prefer `default-on` defense with minimum collateral damage.
- Freeze the output surfaces before tracing: validator rules, tests, and canonical reverse docs.

## Practical Flow

1. Build a repo baseline.
   Read the current packet validators, length table, handler names, packet docs, and existing tests before touching binary conclusions.
2. Build an attack-surface matrix.
   For each packet, record current name, handler or consumer, whether it mutates local state, whether it can indirectly trigger map or event flow, the current guard state, and the recommended action.
3. Split the packet family by evidence strength.
   Use `drop` only for exact harmful behavior already closed by evidence. Use `observe` when semantics are risky but the legal context is still open. Use `research-frontier` when the danger is plausible but the real consumer path is still missing.
4. Separate static tuple rules from state-gated rules.
   Exact event tuples can become deterministic `drop` rules. Move-map or approval flows must stay state-aware.
5. Convert confirmed findings into a table-driven threat layer.
   Give each non-allow rule a stable reason code so logs, tests, and future write-backs stay aligned.
6. Add exact wire-shape validation before semantic policy.
   If a packet family has a confirmed framing or length contract, validate the shape first and fail early on malformed input.
7. Add observe-only instrumentation for frontier families.
   When the semantic chain is still open, emit high-signal logs instead of guessed blocking.
8. Write back docs only after the code path, tests, and evidence wording agree.

## Packet-Family Priorities

- `packet14 MsgMapList`:
  Preserve exact known-dangerous tuples as `drop`. For bonfire, deport, kickout, warp, or map-related remote-allowed tuples, stay in `observe` until the consumer semantics are actually closed.
- `packet16 EventFlagFullSync` and `packet17 WorldSceneSnapshot`:
  Treat these as high-risk snapshot packets. Prefer exact structure validation and conservative logging over speculative semantic filtering.
- `packet57 RemoResourceIdSync`:
  Keep it on the high-risk watchlist. Tighten only confirmed wire shape, then observe until the apply path is closed.
- `packet54/72/73/74/75/76`:
  Treat the move-map and approval cluster as a state-machine surface. Do not hard-block the family without a real move-map window classifier.

## Threat-Spec Contract

Every non-trivial packet rule should answer the same questions:

- What action fires: `drop`, `observe`, or `allow`?
- What stable reason code explains the decision?
- Is the rule exact-shape, exact-tuple, or state-gated?
- What context should be logged: `packetId`, sender, current session or map state, and key fields?
- What test proves the rule and what neighboring legal case proves it does not overreach?

## Evidence Rules

- Handler names, switch labels, and length tables are baseline hints, not final truth.
- A packet should not become `drop` just because its theme sounds dangerous.
- `packet14` expansion must stay exact. Theme words such as `bonfire`, `map`, or `warp` are not enough without a closed consumer path.
- Move-map and approval packets should stay `observe` if the runtime window reader is missing or unstable.
- Shape validation can be stricter than semantic naming. It is valid to reject malformed wire format while still keeping broad semantics conservative.
- Tighten the length table only when repo evidence and binary-backed packet facts agree.

## Good Frontier Questions

- Which exact tuple is already known to be harmful?
- Which part of the chain is still missing: dispatcher, family registration, typed consumer, or apply sink?
- Is the current packet really the dangerous action, or only the transport shell around another event family?
- If a rule were enabled by default today, what legitimate flow could it break?

For bonfire-related `packet14` work, the right frontier is the real dispatch and consume chain, not broader guessing:

- `DispatchEvent2009 -> 4068`
- family `0x42`
- `OnEvent_Bonfire`

## Test And Verification Loop

- Add threat-table tests so every non-allow packet family has a stable expected action.
- For exact-tuple blocks, test both the blocked tuple and adjacent legal tuples.
- For snapshot packets, test canonical shape and malformed framing.
- For move-map or approval surfaces, test both the classifier result and the fallback behavior when runtime state is unavailable.
- Rate-limit repeated logs by `sender + reason` so observation does not become a denial surface itself.
- Verify in two stages:
  1. compile-only to prove the code is syntactically integrated
  2. full build or test run to prove the environment can link and execute

Do not report runtime success when only compile-only passed.

## Write-Back Targets

- Packet matrix under `docs/reverse/network-packets/by-id/`
- Packet-specific fact reports for deep or newly-confirmed behavior
- Validator reason codes and tests kept in sync with the docs

## False Leads To Record

- Promoting a handler label into confirmed semantics
- Treating a remote-allowed event family as globally safe
- Expanding `packet14` drops from keyword similarity instead of exact tuple evidence
- Blocking move-map or approval packets without a real state window
- Declaring the work verified when the full build actually failed on environment or dependency issues
