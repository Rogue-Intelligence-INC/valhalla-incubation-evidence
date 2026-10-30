# Spontaneous Network Emergence, Training Scale, and Results

**Project:** Valhalla (quad-core storage + Tile/StemCell bodies + Fate)
**Date:** 2026-10-31
**Scope:** One directed-cultivation experiment series: relational transitivity
(A>B, B>C ⇒ A>C) trained and tested at very small scale, with full controls.
This document reports what was measured, including the negative results.
It does not claim intelligence.

---

## 1. The System Under Test

- **Quad cores as the only storage.** Four cores (GravityField, MeshBrain,
  Multinova, BaseForceCoordinator), each with its own byte store
  (`stored: Vec<Vec<u8>>`), its own processing function, and its own
  save/load format (magic headers `BHSTORE1` / `MBSTORE1` / `MNSTORE1` /
  `BFSTORE1`). Fed content lives only in these stores.
- **Tile body** (`TileQuattroComplete`): containers born per ingested signal;
  connections form spontaneously inside `propagate()` — a tile whose
  activation exceeds the internal activity condition links to another active
  tile (weight 0.1, Hebbian update afterwards).
- **Stem body** (`StemCellComplete`): cells born through the body's own
  `ingest` → `promote_from_fate` channel (one cell per closed container).
  Connections are written by the physics field: pairwise forces from
  signature similarity, spatial deformation over time, and a neighbor set
  selected by a distance quantile driven by Fate efficiency
  (`neighbor_ratio = 0.1 + efficiency * 0.3`), with connection strength
  `1/(dist+0.1) * sqrt(field_i * field_j) * bulk`. No hand-set strength
  threshold is used on the reading side.
- **Fate**: one global Fate per body ticks every fed signal
  (`receive_passive`): unified metric = efficiency
  (discoveries / signals), an adapting cluster equation, and convergence
  state. Tile and Stem follow the global Fate (`follow_global_fate`).

## 2. Spontaneous Network Emergence (Measured)

After three cultivation stages (~480 fed items, see §3), the body monitor
reported for the cultivated group (C):

| Signal | Start | After cultivation |
|---|---|---|
| Tiles | 0 | 528 |
| Tile edges (spontaneous connections) | 0 | 3,559 |
| Stem cells | 100 (initial) | 501 |
| Stem merges | 0 | 334 |
| Stem field links | 0 | 15,362 |
| Largest Stem connected block | 0 | 242 cells |
| Stem fragment field strength (max) | 0.0000 | 14.96 |

Two different emergence regimes were observed:

- **Tile network saturates.** The Tile graph becomes a dense blob:
  raw reachability over Tile connections answers every transitive question
  (42/42) but also "answers" every reversed question (silence 0/12) and
  leaks across broken chains (silence 1/6). It encodes "everything is
  connected", not chain direction.
- **Stem network is graded.** The field-grown Stem graph, read on its own,
  scores 43/66 (transitive 23/36, reversed silence 6/12, broken-chain
  silence 2/6): partial, directional, strength-graded signal. This is the
  density/weight/spatial-deformation selection of the field operating as
  designed — but it is not yet chain-specific (see §5).

A feeding bug mattered here: Stem cells are only born on Fate convergence
when data enters through `receive_data`. Feeding through the body's own
`ingest` + `promote_from_fate` channel (one cell per fact, position and
signature from that fact's byte statistics) raised cell count from ~110 to
501 and Stem links from 0 to 15,362. The substrate was never broken; the
feeding was not using its birth channel.

## 3. Training Scale vs. Conventional LLMs

| | Qwen2.5-0.5B (reference LLM) | This Valhalla body |
|---|---|---|
| Trainable parameters / containers | ~0.5 × 10⁹ weights | 528 tiles + 511 stem cells |
| Training data volume | ~10¹²–10¹³ tokens (pretraining) | ~480 items, ≈ 3 × 10³ bytes |
| Gradient updates | ~10⁵–10⁶ steps, backpropagation | 0 (no backpropagation anywhere) |
| What is stored | Distributed weights | Raw fed bytes in 4 quad stores + grown structure |
| Test-time teacher | The model itself | None (no external model in any test path) |

The comparison is deliberately unfair in both directions: the LLM was
trained on roughly **nine orders of magnitude** more data. The point of
this experiment is not to compete at that scale; it is to test, at a scale
where every mechanism is inspectable, whether capability can be shown to
live in stored facts + spontaneously grown structure rather than in a
lookup table or an external teacher.

## 4. Results (66-question battery + small intelligence test)

Test design: brand-new symbols per chain (disjoint symbol sets, no
cross-chain leakage), only single links given at test time (the transitive
pair is never stored), four question types — transitive (must answer),
reversed (must stay silent), broken chain (must stay silent), distractor
(must stay silent).

| Group | Answer (of 42) | Silence (of 24) | Interpretation |
|---|---|---|---|
| C — cultivated, storage-graph readout | 42 | 24 | Facts compose transitively |
| A — blank (noise-fed), same readout | 42 | 24 | Composition is done by storage + dumb reader |
| B — answer-lookup (stored Q&A pairs) | 0 | 24 | Memorized answers fail on new symbols |
| D — C saved to disk, quad stores reloaded into a fresh body | 42 | 24 | Capability survives with zero grown structure |
| E — D with quad stores cleared | 0 | 24 | Answers depend solely on quad storage content |
| C — thought channel (global Fate fragment assembly) | 42 | 24 | Fragments assemble into readable chains |

Thought-channel examples (fragment = fact link, number = combined signal
strength, weakest link and converging cycles reported by the global Fate
monitor):

```
DY>DW: DY>DZ(0.97) + DZ>DX(0.99) + DX>DW(0.99)
```

Small intelligence test (live body, new symbols, thought channel;
training chain length ≤ 4):

| Item | Probes | C | A (blank) |
|---|---|---|---|
| 6-link chains ×3 | Length generalization | pass | pass |
| Reversed 6-link ×3 | Direction | pass | pass |
| Interleaved dual chains ×2 | Interference separation | pass | pass |
| Bridge: missing link → silent; link added → answers | On-the-spot completion | pass | pass |
| Re-ask first long chain | Consistency | pass | pass |
| **Total** | | **13/13** | **13/13** |
| Re-ask earliest 6 questions | Retention | 4/6 | 4/6 |

## 5. What the Results Do and Do Not Show

**Shown (with controls):**

1. **Composition is not memorization.** Storing facts and composing them
   beats storing answers 42/42 vs 0/42 on unseen symbols (group B).
2. **Storage-level capability is real and ablatable.** It survives
   save/reload into an empty body (D) and is fully destroyed by clearing
   the quad stores (E: answers 42 → 0). No hidden source exists.
3. **Spontaneously grown structure exists and is substrate-specific.**
   Tile saturates; the Stem field produces graded, partially directional
   topology from density/weight/spatial deformation alone.
4. **The thought channel generalizes in form.** Longer chains than
   trained, interleaved chains, and bridge-completion all work through
   fragment assembly monitored by the global Fate.

**Not shown (stated plainly):**

1. **Incubation gain G = 0 in every battery so far.** The blank group A
   matches the cultivated group C on every score once both receive the
   same test facts. The grown network currently acts as a permissive
   gate; the composition work is done by the fragment assembly over
   freshly fed facts. Cultivation has not yet been shown to add
   capability.
2. **The global monitor's "strongest signal" is not yet informative.**
   After stimulation the dense Tile network lights up almost uniformly
   (fragment strengths ≈ 0.97–1.00), so the strongest fragment is often
   from an unrelated chain. Signal resolution, not selection logic, is
   the bottleneck.
3. **Stem topology tracks density more than content.** The noise-fed
   blank body grew a denser Stem field (23,732 links) and out-reached
   the cultivated body on the Stem-only readout (50/66 vs 43/66).
4. **Retention drifts (4/6).** Thinking itself mutates the network
   (propagation keeps growing connections and updating weights), so
   earlier answers can change. The body changes while it thinks.
5. **The unified Fate metric was found frozen and was fixed during this
   work.** The feeding path never called `receive_passive`, so
   efficiency / signal / discovery counts were all zero and the field's
   density ratio sat at its floor. After wiring the global Fate per
   designed flow: efficiency 0.0075 → 0.0160 (2,880 signals, 46
   discoveries), cluster-equation coefficients adapting. It runs now,
   but discovery events are rare under byte-stream input, so the
   adaptive range is barely used.

## 6. Next Gate (unchanged acceptance criteria)

The decisive missing experiment is one where **facts are not present at
test time**: facts fed only during cultivation, questions asked later
with no re-feeding, answered through the grown structure alone.
Acceptance criteria fixed in advance:

- Cultivated group strictly above blank group (G > 0);
- Destroying the grown structure (keeping storage) drops the score
  (structure-level L > 0);
- The global monitor's strongest fragment lands on the questioned chain.

Until those pass, the correct statement is: *a non-backpropagation
system whose quad storage provably composes facts, survives reload, and
ablates cleanly; whose bodies spontaneously grow observable network
structure; and whose incubation gain is not yet demonstrated.*
