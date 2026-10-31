# Fusion Experiment & Windows Shell — Document Review and Pitch Update

**Date:** 2026-10-31
**Sources read in full:** `valhalla-natural-multimodal-fusion/README.md`,
`docs/SUMMARY_EN.md`, `docs/SUMMARY_ZH.md`,
`artifacts/checkpoint_manifest.json` (plus artifact/script listings);
`valhalla-windows/README.md`, `TRANSFORMER_USE.md`, `native/src/` listing.
Both repositories are local and current; the Windows shell below is the
latest local build. The fusion repo is an internal experiment archive
(marked private/confidential by its owner); this summary references its
documents without copying raw artifacts.

## 1. The fusion experiment, as documented

**Protocol** `valhalla-free-multimodal-fusion-v1` (2026-06-25).

**Question.** After decomposition, can TTS + LLM inputs fed *freely*
into the Valhalla bodies (Hub / Tile / Stem) — no preset routing, no
sidecar JSON, no concat-at-embedding — produce emergent native
multimodal structure under multi-round Fate adaptation?

**Method.** LLM text ports + TTS mel ports (espeak →
`valhalla_dl_front` encoder) are pulsed alternately (text / audio /
mixed) into all three bodies; Fate adapts for 5+ rounds until marginal
stability or convergence. Metrics are discovery-only and self-defined:
Tile/Stem **superadditivity** (fused response > max single-modality),
Hub modality separation, mismatch binding, and a composite
`natural_multimodal_score` → `emergence_likely`.

**Structure-layer results (test, n = 107 prompts):**

| Metric | Smoke (n=4) | Test (n=107) |
|---|---|---|
| Emergence rate | 50% | **64.5%** |
| Avg natural multimodal score | 0.825 | **0.823** |
| Tile superadditivity | 100% | **99.1%** |
| Stem superadditivity | 100% | **100%** |
| Hub modality separation | 0.50 | **0.50** |
| Avg Fate adaptation rounds | 5 | **5** |
| Verdict (repo's own) | CONFIRMED | **POTENTIAL_CONFIRMED** |

**Bake.** Base model `Qwen/Qwen2.5-0.5B-Instruct`, full bake at
strength 0.08, weight-delta norm 196.0, checkpoint ~988 MB kept local
(not in git). Manifest: `artifacts/checkpoint_manifest.json`.

**QA (fair test, 145 prompts):**

| Track | Total | Open | MCQ | Numeric |
|---|---|---|---|---|
| This experiment (baked) | **102/145** | 56/61 | 15/46 | 31/38 |
| Hybrid 2.0 (reference) | 117/145 | 57/61 | 28/46 | 32/38 |
| Prior baked | 115/145 | 56/61 | 26/46 | — |

**Gaps the documents themselves state:**

1. The current bake uses corpus triad incubation + a compose adapter;
   the 107 prompts' free-fusion structure is **not yet aggregated into
   the weights**. The QA number therefore does not test the fusion
   structure itself.
2. MCQ (15/46) lags the hybrid track; the docs propose structure →
   option-affinity / lm_head work as the missing step.
3. All emergence metrics are internal discovery metrics, not external
   benchmarks; the mismatch-control results are only partially present
   in the shipped artifacts.

**Related documented lines:** `compose_fate` (preset text/TTS shards,
per-question runtime recompose) and `model_fate` (Qwen layer weights
decomposed into quads → new checkpoint). The shell's Transformer page
(`TRANSFORMER_USE.md`) confirms the division of labor: the shell only
selects an existing Qwen2.5 checkpoint; decomposition and the Fate
closure check (`decompose_score ≥ 0.75`, `aggregate_score ≥ 0.85` →
`model_recompose_ready`) happen in the main project; original weight
files stay read-only.

## 2. The Windows shell, latest local state

`valhalla-windows` is a chat-first native Windows shell for the
Valhalla runtime: `Valhalla.exe` built from `native/src/` (C++:
`main`, `desktop`, `engine`, `knowledge`, `ocr`, `sessions`, plus
`kb_test`/`agent_test`; VS2022 Build Tools via `native/build.bat`),
with an earlier Python interface of the same shell alongside. It is a
desktop application repository, *not* the research runtime
(`valhalla_base.exe` lives in the licensed Valhalla checkout).

Shipped and working per its README (28 Oct 2026 snapshot; local tree
is the latest): knowledge import in 14 formats with pending-review
marking, conversation library, screen OCR + UI Automation control
listing, computer control **off by default** (gated action set:
`read_screen`, `click`, `click_text`, `move`, `type`, `key`,
`scroll`), a Models page that selects Qwen2.5 Instruct checkpoints
for the runtime to decompose and confirm, and four answer strategies
(faithful retrieval, hybrid multiple choice, follow-up session,
multi-hop). The shell does not train or decompose models itself.

## 3. What this pair of artifacts does and does not establish

- **Established (pipeline level):** an existing LLM can be decomposed
  into Valhalla structural signatures, fused with a second modality
  inside the bodies with measurable, reproducible structure-layer
  effects (superadditivity ≈ 99–100%, emergence 64.5% on the repo's
  own discovery metrics), and written back into a working checkpoint
  copy that still answers open questions at the prior level (56/61).
- **Not established:** that this *enhances* the LLM. The only
  like-for-like QA comparison in the documents has the fused bake
  **below** both references (102 vs 117/145 hybrid, 115/145 prior
  baked), the deficit concentrated in MCQ; and by the docs' own
  statement the bake does not yet contain the fusion structure, so
  the QA gap cannot even be charged to (or credited to) fusion.
- **Product level:** the Windows shell is a real, locally built
  desktop artifact that makes the runtime usable and demonstrates
  the decomposition workflow end-to-end from a user's chair. It is
  not a launched SaaS and claims no customers or revenue.

The honest one-liner for both: **the decompose → fuse → bake pipeline
runs and its structure effects are measured; LLM enhancement is the
open milestone, with aggregating fusion structure into the bake as
the documented next step.**

## 4. Pitch changes made from this review

`Valhalla_Investor_Deck_EN_v1.1.pptx` (Desktop, 18 slides) restructured
the v1.0 deck around the incubation paradigm (cover → paradigm →
thesis → architecture → signal → incubation program → established
evidence → evidence map → structural experiment → open gate → why-now
→ product path → brief sub-lines → funding aligned to the 27 Oct 2026
angel package ($750K target) → contact → appendices). This review
then made the one-page brief (slide 13) document-precise:

- **Windows shell** — "built and running locally", with the feature
  list as shipped (knowledge import, OCR, gated control, model page).
- **Transformer decomposition** — "Qwen layer weights decomposed into
  Hub/Tile/Stem quads (model_fate); a Fate closure check gates the
  bake into a checkpoint copy. Originals read-only."
- **Cross-model fusion** — tagged "structure confirmed, QA open":
  protocol shape, 64.5% emergence (107 prompts), superadditivity
  99–100%, baked 102/145 vs 117/145 hybrid, and the docs' own caveat
  that the fusion structure is not yet in the bake.

No other project lines (S-WIND, Yaksha, Wave, Val-OS as a separate OS
pitch) are presented in this deck; Val-OS appears only as the Windows
shell's research-prototype parent artifact inside that one row.
Build scripts: `build_deck_v1_1.ps1`, `fix_deck_v1_1.ps1`,
`fix_deck_v1_1b.ps1` (Desktop).
