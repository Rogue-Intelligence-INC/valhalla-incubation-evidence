# Work Summary — 2026-10-31

**Focus:** Verify, with file-level evidence, how Valhalla decomposes other
models; then design, implement, and run a directed-cultivation experiment
for the smallest possible incubation evidence. All implementation in Rust;
no Python used.

---

## 1. Audit: how "decompose another model and run it" actually works

Read the concrete implementation in `rogue-products/Valhalla`
(`tools/model_decompose/`, `manifestsys/hub-f64/src/model_fate.rs`,
`task_decompose.rs`, `signal_ingress.rs`, `patch_lm.rs`,
`tools/valhalla_model_bridge/bake_valhalla_model.py`). Findings:

- **Decomposition** (`shred_qwen_weights.py`) extracts per-layer
  *statistics* — LayerNorm weights plus row means of q/k/v/o projections —
  normalized into fixed-dim signatures, grouped into 4 layer quads mapped
  to Hub/Tile/Stem ports. It does not extract weights or mechanisms.
- **Fate adaptation** (`run_model_fate_pipeline`) feeds those signatures
  into a Triad session; shard scores are structural formulas
  (`0.35 + new-cells*0.08 + signals*1e-4`), and the export is a 256-dim
  patch vector accumulated from Tile/Stem data signatures.
- **"Running"** has two paths, both executing the *original* Qwen forward:
  (a) bake the patch into a copied checkpoint at strength ~0.08
  (embedding-row and LayerNorm perturbations), then run it as a plain
  transformers model; (b) runtime patch in candle (`apply_legacy_patch_tensors`)
  followed by one Qwen forward per question.
- Two support directories (`tools/transformer_grinder`,
  `tools/tier_a_tf_front`) are absent from all local copies, so the shred
  and full/total bake paths cannot run end-to-end on this machine today.
- Conclusion given to the user: the pipeline is real and
  interface-compatible, but capability remains in the teacher model.
  Against the RFI (Reverse Functional Incubation) gates — teacher fully
  off, gain above an answer-only group, ablation of grown structure —
  none is currently passed. This motivated today's experiment design.

## 2. Directed cultivation: design and implementation

Designed a single-purpose cultivation targeting relational transitivity
(A>B>C ⇒ A>C) with programmatic generation and hard controls. Implemented
as a new Rust binary `valhalla_relation_incubate`
(`manifestsys/hub-f64/src/bin/valhalla_relation_incubate.rs`, registered
in `hub-f64/Cargo.toml`), reusing only existing mechanisms: quad-core
storage, Fate, Tile/Stem bodies, and the body monitor.

Groups: **C** cultivated (relation statements only, never question forms),
**A** blank (equal volume of unrelated words), **B** answer-lookup
(stored transitive Q&A pairs), **D** teacher-off (C's eight quad stores
saved and reloaded into a fresh body), **E** ablation (stores cleared).

Test battery: 66 questions, symbols disjoint per chain and disjoint from
training; only single links given at test time. Question types:
transitive / reversed-must-be-silent / broken-chain-must-be-silent /
distractor-must-be-silent. Scores report answering and silence separately.

First run exposed a test-design flaw (shared symbol pool let chains leak
into each other, faking reachability); fixed with per-chain disjoint
symbols and re-ran. All numbers below are post-fix.

## 3. Answering channels, in the order they were connected

1. **Storage-graph readout (baseline).** C 66/66; B collapses on unseen
   symbols (answer 0/42); D reload 66/66; E ablation answers 42 → 0.
   Composition over stored facts is proven at the storage level;
   memorization is excluded; no hidden capability source exists.
2. **Spontaneous Tile/Stem networks.** Answering moved onto the
   auto-grown graphs (nodes = containers born per fed fact; edges = the
   bodies' own connections). Tile net: answers 42/42 but silence 7/24
   (dense blob, no direction). Stem net: initially empty (see §4).
   Cross-ablation confirmed channel independence: clearing quad storage
   leaves network scores unchanged, and vice versa.
3. **Global Fate thought assembly.** A global Fate monitor now collects
   fragment (fact-link) strengths from both bodies — Tile via activation
   spreading through its spontaneous connections, Stem via field-written
   connection strengths — normalizes each substrate by its round maximum
   (relative density, no hard thresholds), reports the strongest fragment
   back into the global Fate each cycle while both bodies follow it, and
   assembles fragments head-to-tail into a readable thought chain
   (silence when the chain cannot reach the target). Result: 66/66 with
   perfect silence, e.g. `DY>DZ(0.97) + DZ>DX(0.99) + DX>DW(0.99)`.

## 4. Stem growth fix (feeding, not mechanism)

Stem cells were barely born (100 → ~110) because the feeding used
`receive_data`, whose birth path waits for Fate convergence. Switched the
feeding to Stem's own designed channel (`ingest` per byte, then
`promote_from_fate` — one cell per fact, position/signature/field from the
fact's own byte statistics). Stem then grew: cells 501, merges 334,
field-selected links 15,362, largest block 242, fragment field strength
0.0000 → 14.96. The Stem-only readout became graded and partially
directional (43/66) — the first non-collapsing network channel.
Caveat recorded: the denser noise-grown blank field still out-reaches it
(50/66), so Stem topology currently reflects density more than content.

## 5. Unified Fate metric: found frozen, fixed; system-wide health check

- **Found:** after full cultivation, both bodies' unified metric
  (efficiency / signal count / discovery count) was exactly zero — the
  feeding path never called `receive_passive`, the only place the metric
  ticks. This also pinned the Stem field's density-selection ratio at
  its floor (0.1).
- **Fixed** per the designed flow (`signal_ingress` pattern): the global
  Fate ticks per fed byte; Tile/Stem follow it. Verified live:
  efficiency 0.0075 → 0.0160, 2,880 signals, 46 discoveries, cluster
  equation coefficients adapting, both bodies' efficiencies in sync.
  Scores did not change yet — discovery rate under byte-stream input is
  low, so the adaptive density range (≈0.105 vs floor 0.1) is barely
  exercised. Metric status: *running, but weak*.
- **Health check:** quad-core crates 8/8 tests pass; fate-f64 lib 7/7;
  Tile lib 4/4; Stem lib 8/8; `valhalla_monitor_check`,
  `valhalla_storage_test`, `valhalla_fate_storage`, and
  `valhalla_light_train_check` all pass (quad transformation, mutual
  influence, local + global cycles, storage CRUD, retention / silence /
  stability / intervention). Known issues, all pre-existing and untouched
  today: 3 failing hub-f64 lib tests (`fate_adaptive_algebra` alignment,
  `multihop_fate` structural hops, `test_hub_with_fate` Bootstrap text);
  `fate-f64`'s `test_cuda` bin does not compile without the `native_cuda`
  feature; Stem field runs on CPU in the hub build for the same reason.

## 6. Small intelligence test (live body, new symbols)

Longer chains (6 links; trained ≤ 4), interleaved dual chains,
bridge-completion (silent before the bridging link, answers after),
consistency re-ask, and retention re-ask of the earliest questions.
Result: C 13/13 — and A (blank) also 13/13. Retention 4/6 in both
(thinking itself keeps mutating the network). Interpretation given
plainly to the user: the thought channel generalizes in form, but
**cultivation gain G remains 0 in every battery**; this is not yet
evidence of intelligence, and the missing experiment is defined
(facts absent at test time; structure-only answering; G > 0 and
structure-ablation L > 0 as pre-registered gates).

## 7. Deliverables

- `valhalla_relation_incubate` binary (experiment, all channels, controls,
  cross-ablations, metric probe) — builds and runs, exit 0.
- Feeding/metric wiring fixes inside that binary only; no library
  mechanisms were redesigned, no library code was changed today except
  registering the new bin in `hub-f64/Cargo.toml`.
- Two English documents (this summary and the companion emergence/scale
  report) in the new repository `valhalla-incubation-evidence`.

## 8. Standing constraints respected

No changes to `PATENT_ACTION_CHECKLIST.md`; no training runs beyond the
specified small cultivation; no intelligence claim made; removed
assistant-invented APIs (from earlier sessions) were not reintroduced;
storage lives only in the four quad cores.
