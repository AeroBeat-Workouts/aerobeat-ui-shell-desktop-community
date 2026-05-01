extends GutTest

const ROOT_PLUGIN_CFG := "res://../plugin.cfg"
const TESTBED_MANIFEST := "res://addons.jsonc"

func test_plugin_metadata_matches_pc_first_v1_shell_truth() -> void:
	var config := ConfigFile.new()
	var load_result := config.load(ProjectSettings.globalize_path(ROOT_PLUGIN_CFG))
	assert_eq(load_result, OK, "plugin.cfg should load from the repo root")

	assert_eq(
		config.get_value("plugin", "name"),
		"AeroBeat UI Shell - Desktop Community Edition",
		"Plugin name should stay stable for the desktop community shell"
	)

	var description := String(config.get_value("plugin", "description", ""))
	assert_string_contains(description, "PC-first community UI shell", "Plugin description should state the desktop shell stance")
	assert_string_contains(description, "camera-based Boxing and Flow", "Plugin description should reflect the locked v1 gameplay slice")

func test_testbed_manifest_matches_shell_dependency_contract() -> void:
	var file := FileAccess.open(ProjectSettings.globalize_path(TESTBED_MANIFEST), FileAccess.READ)
	assert_not_null(file, "addons.jsonc should exist in the testbed")
	if file == null:
		return

	var stripped_lines: Array[String] = []
	for line in file.get_as_text().split("\n"):
		var trimmed := line.strip_edges()
		if trimmed.begins_with("//"):
			continue
		stripped_lines.append(line)

	var manifest = JSON.parse_string("\n".join(stripped_lines))
	assert_typeof(manifest, TYPE_DICTIONARY, "Manifest should parse as a dictionary")
	if typeof(manifest) != TYPE_DICTIONARY:
		return

	var addons = manifest.get("addons", {})
	assert_typeof(addons, TYPE_DICTIONARY, "Manifest should define an addons dictionary")
	assert_true(addons.has("aerobeat-ui-core"), "Desktop shell manifest should include aerobeat-ui-core")
	assert_true(addons.has("aerobeat-ui-kit-community"), "Desktop shell manifest should include aerobeat-ui-kit-community")
	assert_true(addons.has("gut"), "Desktop shell manifest should include gut for repo-local tests")
	assert_false(addons.has("aerobeat-core"), "Legacy aerobeat-core should not remain in the desktop shell manifest")
