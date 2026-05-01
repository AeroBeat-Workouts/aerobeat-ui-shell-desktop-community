# aerobeat-ui-shell-desktop-community

**Date:** 2026-05-01  
**Status:** Complete  
**Agent:** Chip 🐱‍💻

---

## Goal

Align `aerobeat-ui-shell-desktop-community` with the locked AeroBeat v1 downscope so it truthfully presents itself as the active near-term community shell for PC-first AeroBeat v1.

---

## Overview

This repo is part of the AeroBeat UI shell layer follow-up from the parent coordination plan in `openclaw-chip`. The work stayed intentionally narrow: audit README/package metadata/testbed manifest/test coverage surfaces, remove stale scope claims, and ensure this shell's positioning matches the downscoped docs truth.

The audit found transition-era dependency drift in the committed `.testbed/addons.jsonc` manifest: the desktop shell still pinned `aerobeat-core` even though the locked shell contract for this slice is `aerobeat-ui-core` + `aerobeat-ui-kit-community` plus test tooling. Repo messaging was also too generic, and the test suite was still a placeholder sanity example instead of checking the shell's actual metadata/manifest truth.

---

## REFERENCES

| ID | Description | Path |
| --- | --- | --- |
| `REF-01` | Parent AeroBeat coordination plan | `/home/derrick/.openclaw/workspace/projects/openclaw-chip/.plans/2026-05-01-aerobeat-ui-shell-downscope-pass.md` |
| `REF-02` | Downscoped docs source of truth | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-docs` |
| `REF-03` | Owning repo | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-ui-shell-desktop-community` |
| `REF-04` | Docs landing page with locked v1 scope | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-docs/docs/index.md` |
| `REF-05` | GDD concept with PC → mobile → VR release order | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-docs/docs/gdd/concept.md` |
| `REF-06` | Desktop shell API doc stub | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-docs/docs/api/ui/shell-desktop-community/index.md` |

---

## Tasks

### Task 1: Audit and align repo truth

**Bead ID:** `oc-3kv`  
**SubAgent:** `primary`  
**Role:** `coder`  
**References:** `REF-01`, `REF-02`, `REF-03`, `REF-04`, `REF-05`, `REF-06`  
**Prompt:** Claim the assigned bead, audit the repo against the downscoped AeroBeat docs truth, implement the required alignment changes, run relevant validation, commit/push to `main`, and leave concise handoff notes for QA.

**Folders Created/Deleted/Modified:**
- `.plans/`
- `.testbed/tests/`

**Files Created/Deleted/Modified:**
- `README.md`
- `plugin.cfg`
- `.testbed/addons.jsonc`
- `.testbed/project.godot`
- `.testbed/tests/test_example.gd`
- `.plans/2026-05-01-desktop-shell-downscope-alignment.md`

**Status:** ✅ Complete

**Results:**
- Rewrote `README.md` so the repo explicitly presents itself as the active PC-first community shell for the locked AeroBeat v1 slice, with camera-only gameplay input and Boxing/Flow called out per `REF-04` and `REF-05`.
- Updated `plugin.cfg` metadata to match the same PC-first desktop-shell positioning instead of a generic desktop interaction-shell description.
- Removed the stale `aerobeat-core` pin from `.testbed/addons.jsonc` so the committed dependency contract now reflects the intended desktop shell surface: `aerobeat-ui-core`, `aerobeat-ui-kit-community`, and `gut`.
- Renamed the hidden workbench in `.testbed/project.godot` to `AeroBeat Desktop Community Shell Testbed` for clearer desktop-shell identity during validation.
- Replaced the placeholder GUT sanity tests with repo-truth assertions that load `plugin.cfg`, verify the PC-first/camera/Boxing+Flow metadata, parse the JSONC manifest, and assert that `aerobeat-core` is absent while the shell dependencies remain present.
- No follow-up bead was required from this repo-local pass; the remaining gap in `REF-06` is an expected docs stub outside this repo's ownership.

---

## Final Results

**Status:** ✅ Complete

**What We Built:** A repo-local downscope alignment pass that makes the desktop shell's docs, metadata, testbed manifest, and validation suite truthfully encode the current AeroBeat v1 direction: desktop community first, camera-only gameplay input, and Boxing/Flow as the official gameplay slice.

**Reference Check:**
- `REF-04` satisfied: repo README now mirrors the locked v1 scope and future-platform wording.
- `REF-05` satisfied: repo messaging now reflects the explicit release order of PC first, mobile second, VR third.
- `REF-06` acknowledged: docs page remains a stub, but no repo-local contradiction remains after this pass.

**Validation:**
- `cd .testbed && godotenv addons install`
- `godot --headless --path .testbed --import`
- `godot --headless --path .testbed --script addons/gut/gut_cmdln.gd -gdir=res://tests -ginclude_subdirs -gexit`
- Result: 2/2 GUT tests passed.

**Commits:**
- `838569d` - Align desktop shell with AeroBeat v1 downscope

**Lessons Learned:** The most valuable low-scope shell cleanup here was turning the test suite from a placeholder into a truth-check for manifest + metadata drift; that gives QA/audit a concrete guardrail instead of relying on README prose alone.

---

*Completed on 2026-05-01*
