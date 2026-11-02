# Valhalla — Incubation Evidence

Evidence record for the Valhalla research programme: controlled experiments
on whether capability, in an implemented Rust structural-learning system,
can be shown to reside in persistent quad storage and in network structure
formed by the system's own dynamics. Positive, negative and null results
are recorded together; every quantitative statement is accompanied by the
protocol that produced it.

The main codebase is
[Rogue-Intelligence-INC/Valhalla](https://github.com/Rogue-Intelligence-INC/Valhalla).
This repository holds the evidence documents, the experiment code as run,
and the current technical report.

---

## Principal results

**1. Structure carries the answer (causal).**
On withheld multi-hop questions, trained bodies answer at **72.2%**
(200 symbols, 15 seeds; per-seed 71.2/72.7) through self-formed
structure. Removing every connection — stored bytes intact — returns
all 15 seeds to a single 45.5% floor: **+26.8 ± 0.7 pp, positive in
15/15 seeds**; cross-chain false questions are correctly rejected at
26.4% under the same geometry (the reachability instrument trades
selectivity for sensitivity; both sides reported). Clearing stored
bytes, by contrast, changes nothing. The effect is therefore
attributable to the network, not to retrieval. (Earlier figures were
retired twice: +27.4 pp under a build whose Stem field had lost its
per-cell connection cap, then +12.7 pp under a build whose field
dimension was set by raw signal magnitude — thousands of dimensions,
degenerating birth geometry; both defects found by measurement,
repaired, and the battery re-run — 2 November 2026. Under the
corrected dynamics, the exposure learning curve at this scale is flat
and the real topology scores below degree-matched random rewiring
under hop-limited scoring — both reported as measured.)

**2. One body, from ingress to egress (end-to-end, deterministic).**
A single 20-round programme feeds facts, text, code, image and audio
through Fate segmentation and scores three egress channels separately on
the same body: stored-fact answers **100/100** through a read-only
interface; storage accounted **to the byte (×8 copies, as designed)**;
body state that freezes and thaws with identical scores. Identical input
and seed reproduce the run bit-for-bit.

**3. Directed curricula: not detected (null, pre-specified).**
Whether chain-structured cultivation exceeds equal-volume unstructured
exposure was written down as a test before it was run (200 symbols,
6-link chains, ~3,600 facts, 15 seeds, three scoring instruments). The
result was **+0.0 ± 0.8 pp** against a matched control. The curriculum
claim has been withdrawn; direction is attributed, on current evidence,
to material selection and the Fate layer only. A width variant
(pre-declared joint criterion, 15 seeds, 2 November 2026) likewise did
not establish topology specificity: hard-negative rejection rose
+23.8 pp (14/15 seeds) while true-pair path length never beat a
degree-preserving shuffle (0/15) — recorded as not detected, with the
component measurements published alongside (EVIDENCE_MAP D13). A
second attempt under a discrimination scale pre-declared for fresh
seeds reached 11/15 against a 12/15 bar and likewise stands as not
detected; a native closed-loop localisation test (stimulus through
the body's own entry, silent-arm differential readout, two surface
forms) also found nothing above chance (D14).

## Evidence classification

- **Class A — reproduced under current code:** causal structure effect
  (above); complete-state persistence (F = C, I = C); byte-exact ×8
  storage accounting; zero storage forgetting (BWT +0.0 pp); the
  consolidated end-to-end pipeline.
- **Class B — reproduced, protocol-bounded:** industry-style battery
  (5 seeds; storage 100%, network channel 49–76% by task family — task
  analogues generated for this programme, not official datasets);
  spontaneous-organisation census at 25–150 MB (formation of opposed
  two-layer topologies; optimality not established, since degree-matched
  rewiring retains task performance).
- **Class C — not established:** directed-curriculum gain (null, above);
  topology specificity under new question types; paraphrase-level
  answering (the read-only interface returns stored originals verbatim;
  multi-hop chaining is performed by the caller); death/cleanup dynamics.
  Class C items appear in no quantitative claim.

## Why these results are reported this way

1. **Criteria before outcomes.** Decisive tests carry pass/fail criteria
   recorded in the run documents before execution, and outcomes are
   reported against them — including failures. (Criteria were documented
   internally in advance; no external registry was used, and no formal
   preregistration is claimed.)
2. **Controls that can only weaken the claim.** Headline numbers are
   accompanied by interventions designed to destroy them: connections
   cleared with storage intact, bytes cleared with structure intact,
   networks rewired at matched degree. Where a control retains
   performance, the claim is narrowed (see organisation, Class B).
3. **Complete runs.** Results are reported per seed (15/15) with spread,
   never as a best run. Adverse readings — e.g. Tile cross-chain false
   reachability rising from 2.1% to 12.5% by round 20 of the pipeline —
   remain in the record.
4. **Labelled provenance.** Self-generated task analogues are labelled
   as such wherever their numbers appear; official-dataset standing is
   claimed only where an official protocol was run.
5. **Repeatability.** The system is deterministic; headline runs repeat
   with one command (`valhalla.exe run`, main repository) and can be
   compared bit-for-bit.

These practices are adapted from published reporting norms: pre-specified
analysis as formalised in Registered Reports (Chambers et al., *Nature
Human Behaviour*, 2021, [doi:10.1038/s41562-021-01193-7](https://doi.org/10.1038/s41562-021-01193-7))
and the NeurIPS reproducibility checklist (Pineau et al.;
[neurips.cc/public/guides/PaperChecklist](https://neurips.cc/public/guides/PaperChecklist)).
Independent third-party replication has not yet taken place.

## Current document set (November 2026)

- [`evidence-20261101/EVIDENCE_MAP_20261101.md`](evidence-20261101/EVIDENCE_MAP_20261101.md)
  — classification of every current claim (A: established; D: not to be
  claimed), with pointers to the runs behind each item.
- [`evidence-20261101/TEST_RUNS_20261101.md`](evidence-20261101/TEST_RUNS_20261101.md)
  — per-run records for the 1 November 2026 full-suite re-run, with the
  saturation and field-dimension correction sections (2 November 2026).
- [`evidence-20261101/ENTRY_FREEDOM_AND_E1W_20261101.md`](evidence-20261101/ENTRY_FREEDOM_AND_E1W_20261101.md)
  — entry-freedom audit and repair (birth form decided at Fate
  close-out), the field-dimension defect and its repair, and the
  pre-registered width-cultivation test E1W with its verdict.
- [`evidence-20261101/RUN_MODE.md`](evidence-20261101/RUN_MODE.md) and
  [`evidence-20261101/FULL_FLOW_RUNBOOK.md`](evidence-20261101/FULL_FLOW_RUNBOOK.md)
  — the consolidated run specification (four layers plus monitoring) and
  the end-to-end pipeline in detail.
- [`evidence-20261101/CANONICAL_METRICS_20260714.md`](evidence-20261101/CANONICAL_METRICS_20260714.md)
  — canonical Tier-A metrics from the Python inference programme
  (U1–U4 4/4; U3 +38.7 pp; TPI 0.755; long-chain drift 0% / retention
  100%), retained with their protocol bounds.
- [`evidence-20261101/DECOMPOSE_EVIDENCE_ASSESSMENT_20261101.md`](evidence-20261101/DECOMPOSE_EVIDENCE_ASSESSMENT_20261101.md)
  — assessment of the LLM-decomposition enhancement line (graded
  Class B: sham control missing, strength post-hoc) and the two-phase
  plan to reproduce it on the Rust incubation body. An instrument
  correction (unified scoring budget, replacing a per-label budget)
  and its 15-seed re-run are recorded in TEST_RUNS (E0 section); a
  second correction (field dimension estimated from signal dispersion
  rather than magnitude) and its re-baseline followed on 2 November
  2026 (TEST_RUNS, dimension section) — current values are those of
  the principal results above.
- [`deck/Valhalla_Investor_Deck_EN_v1.4_20261102.pptx`](deck/Valhalla_Investor_Deck_EN_v1.4_20261102.pptx)
  — the current technical report (29 slides, Scientific Edition):
  principal results first, experiments in full, evidence classification
  and reporting standard included. v1.4 re-baselines to the
  field-dimension-corrected dynamics (2 November 2026) and reports
  the E1W width test as not detected.

## Earlier documents (October 2026, retained as run)

- [Explanation](EXPLANATION.md) — components, experiment design, results,
  and the pre-specified gates as originally written.
- [Spontaneous Network Emergence, Training Scale, and Results](SPONTANEOUS_NETWORK_AND_SCALE.md)
- [Suite 3 — Incubation Causal Proof v1](SUITE3_CAUSAL_PROOF_SUMMARY.md)
- [Industry-Style Battery](INDUSTRY_BATTERY_SUMMARY.md)
- [Test Package](TEST_PACKAGE.md) — the runnable battery in `code/`,
  with pre-specified interpretation rules.
- [Fusion & Windows Shell Summary](FUSION_AND_SHELL_SUMMARY.md) ·
  [Suite 2 — 20-Round Summary](SUITE2_20ROUND_SUMMARY.md) ·
  [Work Summary — 2026-10-31](WORK_SUMMARY_2026-10-31.md)

## Code

Experiment programmes as run are preserved in [`code/`](code/)
(relation incubation, industry battery, incubation proof, Fate decision
check, body monitor, and the one-shot test runner). The maintained
implementations, including the unified `valhalla` entry point, live in
the main repository.

---

*Rogue Intelligence Inc. · Evidence as of 1 November 2026.*
