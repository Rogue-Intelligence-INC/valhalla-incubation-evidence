# Valhalla Incubation Test Package

**Version:** 2026-10-31 · **Location:** `code/` in this repository
**Purpose:** the complete, runnable test battery behind every claim in
this evidence repo — packaged so anyone can reproduce the numbers with
one script, and so the results can be checked rather than trusted.

The package tests one question from several directions: *does
cultivation (feeding facts into the Tile/Stem bodies) produce
structure that carries answers, beyond what the stored bytes alone
explain?* Every test reports its control groups alongside its scores.
Where the answer so far is "not yet", the package says so in its own
output — that is what it is for.

---

## Package contents

| File | Layer | What it tests |
|---|---|---|
| `code/monitor.rs` | Shared | Observation-only body monitor (`BodyMonitor`): tiles/cells, merges, edges, connection births, field links. Required by all bins below; replaces `manifestsys/hub-f64/src/monitor.rs`. Contains no decision logic. |
| `code/valhalla_fate_decision_check.rs` | Probe | Does global Fate (`follow_global_fate`) actually feed back into structure? Runs identical cultivation with live vs frozen Fate and diffs the resulting bodies. |
| `code/valhalla_relation_incubate.rs` | Suite 1 | Directed relational-transitivity cultivation (10 rounds default): A/B/C/D/E groups (blank / lookup-only / cultivated / save-reload / clear-content), three readout channels (storage graph, Tile/Stem network, global-Fate thought assembly), plus a small intelligence battery (long chains, dual chains, bridge completion, consistency, retention). |
| `code/valhalla_relation_incubate2.rs` | Suite 2 | 20-round per-round-novelty curriculum (chain length 3→8, branching from round 11), graded scoring (mean thought strength, strongest-fragment-on-chain rate), morphology → answering. |
| `code/valhalla_incubation_proof.rs` | Suite 3 | Causal proof battery over 5 seeds: C cultivated / A blank / F full-state restore / G structure ablation / H degree-matched rewiring / I store clearing. Network channel only. |
| `code/valhalla_industry_battery.rs` | Industry analogues | T1 rule induction with facts withheld at test, T2 SCAN-style length generalization, T3 CLUTRR-style pedigree multi-hop, T4 continual learning (backward transfer). Self-generated analogues — **not** official benchmark scores. |
| `code/run_tests.ps1` | Runner | Builds and runs the whole package, logging to `test_logs/`. |

Repository documents that interpret each layer:
`EXPLANATION.md` (whole system), `SPONTANEOUS_NETWORK_AND_SCALE.md`
(Suites 1), `SUITE2_20ROUND_SUMMARY.md`, `SUITE3_CAUSAL_PROOF_SUMMARY.md`,
`INDUSTRY_BATTERY_SUMMARY.md`, `WORK_SUMMARY_2026-10-31.md`.

---

## Prerequisites

- The Valhalla repository (this package only ships the test bins and
  the monitor; the tested system — quad cores, Tile, Stem, Fate —
  lives there, `manifestsys/hub-f64` and sibling crates).
- Rust toolchain (`cargo`).
- For GPU Stem field: CUDA toolkit; the builds in this repo used
  `RUSTFLAGS=-L C:\Ai\cuda-libx64` and CUDA v13.4 `bin` on `PATH`
  (RTX 4090). Without CUDA the field falls back to CPU in non-CUDA
  builds and Stem numbers change; CPU-only runs are valid but not
  comparable to the recorded ones.
- `stem-cell` must be built with `features = ["native_cuda"]` in
  `hub-f64/Cargo.toml` for the GPU field (already the case in the
  tested tree).

## Install (into a Valhalla checkout)

1. Copy `code/monitor.rs` over `manifestsys/hub-f64/src/monitor.rs`.
2. Copy the five `code/valhalla_*.rs` bins into
   `manifestsys/hub-f64/src/bin/`.
3. Register the bins in `manifestsys/hub-f64/Cargo.toml`:

```toml
[[bin]]
name = "valhalla_relation_incubate"
path = "src/bin/valhalla_relation_incubate.rs"

[[bin]]
name = "valhalla_relation_incubate2"
path = "src/bin/valhalla_relation_incubate2.rs"

[[bin]]
name = "valhalla_fate_decision_check"
path = "src/bin/valhalla_fate_decision_check.rs"

[[bin]]
name = "valhalla_incubation_proof"
path = "src/bin/valhalla_incubation_proof.rs"

[[bin]]
name = "valhalla_industry_battery"
path = "src/bin/valhalla_industry_battery.rs"
```

## Run

Full package (PowerShell, from the Valhalla repo root):

```powershell
# copy code\run_tests.ps1 to the Valhalla repo root first, then:
.\run_tests.ps1                 # ~20 min total; Suite 2 dominates
.\run_tests.ps1 -Quick          # probe + proof + industry only (~1 min)
```

Individual bins and knobs:

| Command | Knobs | Typical time |
|---|---|---|
| `cargo run -p hub-f64 --bin valhalla_fate_decision_check` | — | seconds |
| `cargo run -p hub-f64 --bin valhalla_incubation_proof` | `VALHALLA_PROOF_SEEDS=1,2,3` | ~10 s (5 seeds) |
| `cargo run -p hub-f64 --bin valhalla_industry_battery` | `VALHALLA_IND_SEEDS=1,2,3` | ~30 s (5 seeds) |
| `cargo run -p hub-f64 --bin valhalla_relation_incubate` | `VALHALLA_REL_ROUNDS=10` | ~80 s @ 5 rounds |
| `cargo run -p hub-f64 --bin valhalla_relation_incubate2` | — (fixed 20 rounds) | ~13 min |

Library health layer (the system's own unit tests, run before the
package was trusted): `cargo test -p` for the four quad crates
(8/8), `fate-f64` (7/7), Tile (4/4), Stem (8/8). Three pre-existing
`hub-f64` failures (`fate_adaptive_algebra`, `multihop_fate`,
`test_hub_with_fate`) predate this package and are unrelated to it.

---

## Headline results this package currently produces

(5 seeds where applicable; see the per-suite summaries for full tables.)

| Test | Result | Verdict |
|---|---|---|
| Suite 1 storage graph (C/A/B/D/E) | 66/66, B lookup 0/42, D reload 66/66, E cleared → 0 | Quad-store composition with controls: **passed** |
| Suite 1 network / thought | Tile 49/66, thought assembly 66/66 but C = A | Cultivation gain G = 0 |
| Suite 2 (20 rounds, novelty) | morphology grows every round; graded readout saturates (0.999 both bodies) | Growth real; discrimination unmeasurable |
| Suite 3 F (full-state restore) | F = C exactly | **Complete-body persistence: passed** |
| Suite 3 G/H/I | L = C−G = +27.3 pp; H rewired = C; I cleared = C | Structure is load-bearing, but **density, not cultivated topology** (C − H = 0) |
| Industry T1–T4 | Storage 100% everywhere, BWT = 0; network = positive-rate of each battery | Network: perfect recall, **zero selectivity** |

## How to read the output (pre-registered interpretation)

- **G = C − A** (cultivation gain over an equal-volume blank) and
  **C − H** (cultivated topology vs degree-matched random rewiring)
  are the two numbers that would demonstrate incubation. Both are
  currently **0**. Any future run that changes this — in either
  direction — is the news; raw accuracy is not.
- Scores of the form X.7 / X.3 repeating across seeds mean the boolean
  reachability readout has quantized (dense structure answers
  everything). Treat zero variance as a readout warning, not as
  stability.
- The industry battery is analogue-shaped by design. MiniGrid Memory,
  Bongard-LOGO and ARC-AGI are deliberately **not** included: they
  need action/visual channels the architecture does not have, and an
  adapter that supplied them would be the invention itself, not a
  test of this system.

## One-line status

The package reproducibly shows: exact, forgetting-free quad storage;
a fully save/restorable cultivated body; load-bearing grown
structure whose value is currently density rather than cultivated
topology; and a network readout with perfect recall and no
discrimination. The next gate it is built to detect is **C > H**.
