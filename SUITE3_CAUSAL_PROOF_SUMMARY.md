# Suite 3 — Incubation Causal Proof v1 (F/G/H/I, 5 seeds)

**Date:** 2026-10-31
**Code:** `code/valhalla_incubation_proof.rs`
(`manifestsys/hub-f64/src/bin/valhalla_incubation_proof.rs` in the main repo)
**Protocol:** unchanged from Suites 1–2 (facts given at test time as
premises; per-chain disjoint unseen symbols; silence scored separately).
Answering channel for this suite: **structure only** — reachability over
the Tile/Stem spontaneously grown connections. No storage bytes are read,
no fragment chaining is performed, so that structural ablations can
actually bite.

## New control groups (per ChatGPT-route review, Phase 1)

| Group | Construction | Tests |
|---|---|---|
| C | Cultivated body (3 stages, ~480 items) | baseline |
| A | Blank body, equal volume of noise words | cultivation control |
| F | C fully saved (body slices + tile/cell JSON + 8 quad stores + global Fate) and restored into a fresh body | complete-state persistence |
| G | Restored C with **all Tile/Stem connections removed**, storage untouched | structure causal contribution |
| H | Restored C with **connections rewired**: same nodes, same per-node degree (and same Stem strength multiset), random targets | topology vs. mere density |
| I | Restored C with **quad stores cleared**, structure untouched | storage independence of the structure channel |

Five seeds; identical battery of 66 questions per seed (transitive /
direct / reversed-silent / broken-silent / distractor-silent).

## Results (network channel, % correct, mean ± std over 5 seeds)

| C | A | F | G (no structure) | H (rewired) | I (no storage) |
|---|---|---|---|---|---|
| 72.7 ± 0.0 | 72.7 ± 0.0 | 72.7 ± 0.0 | 45.5 ± 0.0 | 72.7 ± 0.0 | 72.7 ± 0.0 |

Derived:

- **Cultivation gain G = C − A = +0.0 ± 0.0 pp**
- **Structure causal contribution L = C − G = +27.3 ± 0.0 pp**
- **Topology specificity C − H = +0.0 pp**

Per-seed rows were identical in all five seeds (48/66 vs 30/66 quanta).

## What this proves, and what it does not

**New and established:**

1. **Complete cultivated state is persistent (F = C).** For the first
   time, the full body — tiles, cells, Fate state, and quad stores —
   was saved and restored into a fresh body with zero score change.
   Earlier suites only proved quad-store persistence (their D group).
2. **Structure causally carries the structure-channel answers
   (L = +27.3 pp).** Removing all connections drops accuracy from
   72.7% to the silence floor (45.5% = all silence items plus direct
   links). The answers on this channel are not produced by the reader
   alone; they need the grown connections.
3. **The structure channel is storage-independent (I = C).** Clearing
   every quad store does not change network answers, cross-confirming
   the earlier storage-side ablation in the other direction.

**Established as *not* yet true:**

4. **It is density, not cultivated topology (C − H = 0).** A
   degree-matched random rewiring answers identically. At current
   densities the grown graph is a near-uniform blob: having *many*
   connections is what carries reachability, not *which* connections
   cultivation grew. This is the density confound, now demonstrated
   inside a controlled ablation rather than inferred.
5. **Cultivation gain remains G = 0** on this channel too, in all five
   seeds. Cultivated and noise-grown bodies are indistinguishable to
   the readout.
6. **Zero variance is a warning, not a virtue.** Identical scores in
   every seed mean the boolean reachability readout is too coarse at
   this density — it has essentially two outcomes. Finer readouts
   (strength-graded) saturate on the Tile side (≈0.999 everywhere, see
   Suite 2). Signal resolution remains the bottleneck, now confirmed
   from three independent directions.

## Status against the pre-registered gates

| Gate | Status |
|---|---|
| Complete state saves/restores with no loss (F) | **Passed** |
| Destroying structure drops the score (L > 0) | **Passed** (vs. empty structure) |
| Cultivated topology beats degree-matched random topology (C > H) | **Not passed** — the decisive remaining gate |
| Cultivation gain over blank (G > 0) | **Not passed** |
| Multi-seed reporting | Done (5 seeds); variance is zero because the readout is coarse, not because the effect is stable |

## One-line status

The body can now be frozen, restored, and causally dissected; its
connections provably carry the answers on the structure channel — but
so do random connections of the same density. Until cultivated
topology beats a degree-matched shuffle (C > H), the honest claim
remains: **organization is real and load-bearing; cultivation-specific
organization is not yet demonstrated.**
