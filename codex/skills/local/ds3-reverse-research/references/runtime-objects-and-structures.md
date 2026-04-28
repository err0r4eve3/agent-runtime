# Runtime Objects And Structures

Use this reference for player runtime model work, gameplay structures, bullet layouts, item-drop modeling, and wrapper-vs-owner recovery.

## Recovery Goals

- Identify the real runtime owner instead of stopping at a project wrapper.
- Recover object graph and child relationships before overnaming members.
- Separate local authoring input, sync payload, serializer boundary, and runtime apply sink.
- Keep struct names tied to stable anchors and role, not one offset guess.

## DS3-Tools Repo Surfaces

- `docs/topics/player-runtime-model.md`
- `docs/topics/bullet-structure.md`
- `docs/topics/item-drop.md`
- `docs/reverse/gameplay-systems/bullet_structure_analysis.md`
- `docs/reverse/runtime-addresses/address_tree_ds3proxy_runtime_game.md`
- `docs/reverse/runtime-addresses/address_tree_verification_queue.md`

## Object-Model Pattern

1. Start from the current wrapper or access path.
2. Ask what real runtime object it likely points into.
3. Follow ctor chains, stable child objects, and repeated caller families.
4. Only then decide whether the current offset deserves a stable member name.

For player work, keep wrapper objects, runtime player objects, and game-data side objects separate unless the chain is closed.

## Structure-Recovery Pattern

- For bullets, item drops, and similar gameplay features, split the task into:
  - local input or authoring structure
  - sync or network-facing structure
  - runtime apply or consumption path
- Do not assume those layers share the same exact layout.
- If only one layer is recovered, name that layer conservatively instead of projecting the whole feature model onto it.

## Stable Naming Rules

- One offset plus one guessed meaning is not enough.
- Prefer names backed by owner type, child-object role, repeated callers, or stable usage clusters.
- If only the family is clear, use a broad semantic label.
- If even family is not stable, keep `Unknown` and strengthen notes.

## Useful Blockers

- Wrapper found, real owner unknown:
  move into ctor chain, repeated callers, or child-object accessors.
- Struct seems stable, serializer boundary unknown:
  chase the copy, export, or apply boundary before naming fields aggressively.
- Local feature behavior is clear, network or runtime sink is not:
  document the known layer and stop there.

## Canonical Targets

- `docs/topics/player-runtime-model.md` for player object and ownership questions
- `docs/topics/bullet-structure.md` for bullet modeling boundaries
- `docs/topics/item-drop.md` for item-drop implementation and structure boundaries

## False Leads To Record

- Project wrapper names treated as native owner truth
- One constructor or one field neighborhood treated as full class proof
- Local feature input treated as network or runtime sink layout
- Topic summaries changed without syncing the relevant address tree or queue notes
