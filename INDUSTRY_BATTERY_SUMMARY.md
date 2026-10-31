# Industry-Style Battery — SCAN / CLUTRR / Continual-Learning / Rule-Induction Analogues

**Date:** 2026-10-31
**Code:** `code/valhalla_industry_battery.rs`
(`manifestsys/hub-f64/src/bin/valhalla_industry_battery.rs` in the main repo)
**Seeds:** 5 per test. All tasks are **self-generated analogues** in the
spirit of the named industry benchmarks — these are *not* official
SCAN/CLUTRR/ARC scores, and no external dataset was used. Facts are
given at test time as premises except in T1, whose entire point is
withholding them (a separate battery; the standing protocol of the
other suites is unchanged).

Two readout channels are scored separately throughout:

- **Storage channel** — a dumb directed-reachability reader over the
  quad-store bytes only.
- **Network channel** — reachability over the Tile/Stem spontaneously
  grown connections only (birth-node sets tracked during feeding).

## Results (%, mean ± std over 5 seeds)

### T1 — Rule induction, facts withheld at test (GPT "Experiment A" analogue)

Training: 12 disjoint 5-symbol chains, 3 passes. At test time **nothing
is fed**; questions are labeled by the transitive closure of the
trained edges (offline ground truth): 60 positives (1–4 hops) + 30
negatives (reversed + cross-chain).

| Channel | Overall | 2-hop | 3-hop | Silence (negatives) |
|---|---|---|---|---|
| C storage | 100.0 ± 0.0 | — | — | — |
| C network | 66.7 ± 0.0 | 100.0 | 100.0 | **0.0** |
| A (noise) network | 33.3 ± 0.0 | | | |

### T2 — SCAN-style length generalization

Train on chains ≤3 vs ≤6; test on 6-chains (facts given at test):
48 positives (incl. 4–5 hop) + 12 reversed negatives.

| Body | Network overall | Network 4–5 hop |
|---|---|---|
| Short-trained (≤3) | 80.0 ± 0.0 | 100.0 |
| Long-trained (≤6) | 80.0 ± 0.0 | 100.0 |
| Storage (both) | 100.0 | |

### T3 — CLUTRR-style pedigree multi-hop

Generated 3-generation families (edge = parent-of), facts given at
test: 30 positives (direct + grandparent) + 30 negatives (reversed,
sibling, cross-family).

| Channel | Overall | 2-hop (grandparent) | Reversed silence | Sibling silence |
|---|---|---|---|---|
| Storage | 100.0 ± 0.0 | — | — | — |
| Network | 50.0 ± 0.0 | 100.0 | **0.0** | **0.0** |

### T4 — CL-bench-style continual learning

Learn task 1 → test → learn a disjoint task 2 → retest task 1
(facts withheld on retest). Backward transfer BWT = after − before.

| Channel | Task 1 before | Task 1 after task 2 | Task 2 | BWT |
|---|---|---|---|---|
| Storage | 100.0 | 100.0 | 100.0 | **0.0 pp** |
| Network | 66.7 | 66.7 | 66.7 | 0.0 pp |

## Interpretation — one pattern explains every number

**The network channel has perfect recall and zero selectivity.**
In every test it answers "reachable" to essentially everything:
sensitivity 100%, specificity 0%. Consequently each network score is
arithmetically determined by the battery's positive fraction
(T1 60/90 = 66.7, T2 48/60 = 80.0, T3 30/60 = 50.0, T4 20/30 = 66.7).
This is the Tile-saturation / density-blob behavior already identified
in Suites 1–3 and in the Suite-3 rewiring control, now confirmed from
four more independent directions:

- It is not a retention failure (T1: trained positives are answered
  at 100% with **no** test-time feeding — the structure does retain).
- It is not a length-generalization failure that more long-chain
  training fixes (T2: short- and long-trained bodies are identical).
- It is not interference/forgetting (T4: nothing is lost after a
  second task; on the storage channel BWT = 0 with both tasks at
  100% — the append-only quad stores genuinely do not forget or
  interfere at this scale).
- It is a **discrimination** failure: the grown structure does not
  separate "connected by the facts" from "merely present". Until the
  readout/structure gains signal resolution, composition-style
  industry tests collapse to their positive rate and cannot measure
  the thing they are designed to measure.

**The storage channel is exact everywhere** (100% on every test,
including withheld-facts retest). This re-confirms, at industry-test
shapes, that quad-store fact retention + directed composition over
stored facts is solid — and that none of it depends on cultivation,
which is precisely why the cultivation question must be asked on the
network channel, where the answer remains: recall without
discrimination, cultivation gain still indistinguishable (cf.
Suite 3: C − H = 0 against degree-matched rewiring).

**Zero variance everywhere (±0.0)** is again the coarse boolean
readout quantizing outcomes, not evidence of stability.

## Not run, and why (no fake adapters)

| Benchmark | Status | Reason |
|---|---|---|
| MiniGrid Memory | Blocked | Requires an action/observation interaction loop; the architecture has no action-output channel. Building one is an architecture decision, not a test adapter. |
| Bongard-LOGO | Blocked | Visual concept induction; no image/grid input channel exists. |
| ARC-AGI-2/3 | Blocked | Grid transformation induction; no grid encoder or transformation mechanism exists. Any "adapter" that solved these would be the actual invention, smuggled in as test plumbing. |
| Official SCAN / CLUTRR datasets | Not used | No dataset pipeline in-repo; the analogues above are self-generated and labeled as such. Official numbers would not be comparable anyway until the readout discriminates. |

## Status line

Industry-shaped tests change nothing about the diagnosis and sharpen
it: **storage and retention are exact and forgetting-free; the grown
network recalls everything and discriminates nothing.** The next
measurable gate remains Suite 3's: cultivated topology must beat a
degree-matched random rewiring (C > H) under a readout with signal
resolution.
