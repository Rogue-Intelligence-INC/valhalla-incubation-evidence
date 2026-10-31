# Suite 2 — 20-Round Novelty Curriculum: Morphology to Answering

**Date:** 2026-10-31
**Code:** `code/valhalla_relation_incubate2.rs` (bin `valhalla_relation_incubate2`)
**Changes vs Suite 1:** (1) every round feeds a *new pattern* — chain length
grows 3 → 8 across rounds, branching (one-to-many) facts added from round 11,
because Fate ignores duplicate knowledge; (2) 20 rounds instead of 10;
(3) graded readout added — average thought strength and whether the global
monitor's strongest fragment lands on the questioned chain.
Test protocol unchanged (facts given as premises at test time; user decision).

Runtime: ~13 minutes on RTX 4090 (GPU field step every round).

---

## 1. Morphology across 20 rounds (cultivated group C)

| Round | Tiles | Cells (net) | Stem merges (cum.) | Stem links | Quad-stored items | Fate discoveries (cum.) | Avg Stem link strength |
|---|---|---|---|---|---|---|---|
| 1 | 250 | 331 | 58 | 1,420 | 2,000 | 19 | 0.725 |
| 5 | 1,325 | 1,186 | 578 | 131,640 | 10,600 | 24 | 0.914 |
| 10 | 3,100 | 2,512 | 1,576 | 620,184 | 24,800 | 26 | 0.518 |
| 15 | 5,700 | 4,450 | 3,000 | 1,932,532 | 45,600 | 29 | 0.396 |
| 20 | 8,825 | 6,679 | 4,892 | 4,392,334 | 70,600 | 34 | 0.312 |

- **Iteration is cumulative, verified per round:** storage grows linearly,
  cells grow net of merges, merges and connections grow monotonically.
  No round restarts or loses prior structure.
- **Novelty kept Fate discovering (partial win):** discoveries rose
  19 → 34 across 20 rounds instead of freezing after round 1 as in
  Suite 1 (frozen at 46). New patterns per round do register — but the
  rate is a trickle, efficiency still dilutes to 0.0006, and average
  connection strength still falls (0.73 → 0.31) because link count grows
  quadratically. Strengthening is visible in totals (merges, links,
  organization), not in averages.
- The whole Stem body becomes one connected block early and stays there;
  block structure has no resolution at this scale, same saturation family
  as the Tile blob.

## 2. Answering (same 66-question battery + small intelligence test)

| Channel | C (cultivated) | A (blank) |
|---|---|---|
| Storage-graph readout | 66/66 | 66/66 |
| Tile network only | 49/66 (silence 7/24) | 49/66 |
| Stem network only | **50/66** (answer 40/42, silence 10/24) | 50/66 (answer 38/42, silence 12/24) |
| Thought assembly | 66/66 | 66/66 |
| Small intelligence test | 13/13 | 13/13 |
| Retention re-ask (earliest 6) | **6/6** | 4/6 |
| Teacher-off reload (D, storage) | 66/66 | — |
| Ablation (E, stores cleared) | answers 0/42 | — |

Graded readout (new in Suite 2):

| Metric | C | A |
|---|---|---|
| Average thought strength (answered) | 0.999 | 0.999 |
| Strongest fragment on the questioned chain | 1/42 | 1/42 |
| Test-fragment Stem field strength (max) | 1.34 | 1.47 |

## 3. What changed vs Suite 1 — and what did not

**Changed:**

1. **C caught up on the Stem-only channel** (50/66, tying A; Suite 1 was
   43–47 vs A's 50). Twenty rounds of novelty curriculum closed the gap
   on the one substrate with graded topology.
2. **Retention in C is now 6/6** (was 4/6 in both Suite-1 runs). The
   cultivated body's earlier answers survived the full test sequence;
   the blank body still drifted (4/6). Single observation, not yet a
   claim — but it is the first retention asymmetry in C's favor.
3. **Fate discovery no longer fully frozen** (see §1).

**Did not change:**

1. **Boolean G is still 0.** Every headline score still ties C and A.
2. **The graded readout is saturated by Tile.** Average thought strength
   is 0.999 in both groups and the monitor's "strongest fragment" lands
   on the questioned chain only 1/42 times in both — Tile activation
   (tanh over a dense blob) maxes every fragment, so the combined
   strongest-signal selection still has no resolution. The bottleneck
   identified in Suite 1 is confirmed, not removed.
3. **Suite 1's Stem-strength separation did not replicate.** At 10 rounds
   the test-fragment field strength was 34.7 (C) vs 1.5 (A); at 20-round
   scale it is 1.34 vs 1.47. That indicator was scale-dependent and is
   withdrawn as evidence; with ~6.7k cells the field's density selection
   hands every new cell many weak links, and the maximum is noise-level
   in both bodies.

## 4. Honest status after Suite 2

- Morphology: unambiguous. Twenty rounds of accumulated, reorganized
  growth — 8,825 tiles, 6,679 cells, 4,892 merges, 4.39M field-selected
  links, 70,600 stored items — all inspectable, all monotone.
- Answering: the composition/silence machinery is robust at this scale;
  teacher-off persistence and ablation still hold exactly.
- Incubation gain: **still not demonstrated on boolean scores.** The two
  forward signals are narrow and preliminary: C ties (no longer trails)
  on the Stem channel, and C's retention held at 6/6 while A drifted.
  The decisive blocker is now precisely located: signal resolution in
  the Tile substrate saturates the global monitor's selection. Until
  fragment strengths differentiate (chain fragments stronger than
  off-chain fragments), no scoring rule on top can separate C from A.
