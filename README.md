# AeroBeat UI Shell - Community Edition - Desktop

This repo is the active near-term **desktop community UI shell** for AeroBeat v1.

It should be read against the locked product direction from `aerobeat-docs`:

- **Primary release target:** PC community edition
- **Official v1 gameplay features:** Boxing and Flow
- **Official v1 gameplay input:** camera only
- **Future platform work:** mobile, web, and XR remain follow-on shells rather than equal-status v1 targets

## 📋 Repository Details

- **Type:** UI Shell
- **Platform stance:** desktop / PC-first community shell
- **License:** **GNU GPLv3** (Strict Copyleft)
- **Dependency contract:**
  - `aerobeat-ui-core` — required shared UI logic contract
  - `aerobeat-ui-kit-community` — pinned community visual layer
  - additional lane repos only when this shell actually consumes them

## GodotEnv development flow

This repo uses the AeroBeat GodotEnv UI shell convention.

- Canonical dev/test manifest: `.testbed/addons.jsonc`
- Installed dev/test addons: `.testbed/addons/`
- GodotEnv cache: `.testbed/.addons/`
- Hidden workbench project: `.testbed/project.godot`
- Repo-local unit tests: `.testbed/tests/`

The repo root remains the package/published boundary for downstream consumers. Day-to-day development, debugging, and validation happen from the hidden `.testbed/` workbench using the pinned OpenClaw toolchain: Godot `4.6.2 stable standard`.

### Restore dev/test dependencies

From the repo root:

```bash
cd .testbed
godotenv addons install
```

That restores this repo's current dev/test manifest into `.testbed/addons/`. Canonically, the desktop shell manifest should stay narrow: shared UI logic, the community UI kit, and test-only tooling.

### Open the workbench

From the repo root:

```bash
godot --editor --path .testbed
```

Use this `.testbed/` project as the canonical direct-development and bugfinding surface for desktop shell work.

### Import smoke check

From the repo root:

```bash
godot --headless --path .testbed --import
```

### Run unit tests

From the repo root:

```bash
godot --headless --path .testbed --script addons/gut/gut_cmdln.gd \
  -gdir=res://tests \
  -ginclude_subdirs \
  -gexit
```

### Validation notes

- `.testbed/addons.jsonc` is the committed dev/test dependency contract.
- The canonical manifest for this shell is `aerobeat-ui-core` + `aerobeat-ui-kit-community` + `gut`.
- Mobile, web, and XR shells may continue to exist as future platform paths, but this repo is the current PC-first community shell.
- Repo-local unit tests live under `.testbed/tests/` and currently validate repo metadata plus the manifest contract.
- The current package shape is consumed from the repo root (`subfolder: "/"`) for downstream installs.
