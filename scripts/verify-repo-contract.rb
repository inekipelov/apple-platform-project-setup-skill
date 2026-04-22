#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "yaml"

ROOT = File.expand_path("..", __dir__)
PLUGIN_NAME = "apple-platform-project-setup"
PLUGIN_ROOT = "plugins/#{PLUGIN_NAME}"
PLUGIN_MANIFEST_PATH = "#{PLUGIN_ROOT}/.codex-plugin/plugin.json"
MARKETPLACE_PATH = ".agents/plugins/marketplace.json"
ORCHESTRATION_SKILL = "apple-platform-project-setup-skill"
PLUGIN_SKILLS = %w[
  apple-platform-project-setup-skill
  apple-platform-capability-discovery
  apple-platform-project-interview
  apple-platform-workspace-selection
  apple-platform-capability-install
  apple-platform-codex-config
  apple-platform-artifact-application
  apple-platform-agents-rendering
  apple-platform-setup-verification
].freeze
LEAF_SKILLS = PLUGIN_SKILLS - [ORCHESTRATION_SKILL]

def repo_path(relative_path)
  File.join(ROOT, relative_path)
end

def read_file(relative_path)
  File.read(repo_path(relative_path))
end

def assert(errors, condition, message)
  errors << message unless condition
end

def parse_frontmatter(relative_path)
  content = read_file(relative_path)
  match = content.match(/\A---\n(.*?)\n---\n/m)
  raise "Missing YAML frontmatter in #{relative_path}" unless match

  frontmatter = YAML.safe_load(match[1]) || {}
  body = content[match.end(0)..] || ""
  [frontmatter, body]
end

errors = []

yaml_files = %w[
  catalog.yaml
  inventory/skills.yaml
  inventory/subagents.yaml
  .github/release.yml
] + Dir.chdir(ROOT) do
  Dir[".github/workflows/*.{yml,yaml}"] +
    Dir["snippets/**/*.{yml,yaml}"] +
    Dir["#{PLUGIN_ROOT}/skills/*/agents/openai.yaml"]
end

yaml_files.each do |relative_path|
  YAML.load_file(repo_path(relative_path))
end

plugin_manifest = JSON.parse(read_file(PLUGIN_MANIFEST_PATH))
marketplace = JSON.parse(read_file(MARKETPLACE_PATH))
catalog = YAML.load_file(repo_path("catalog.yaml"))
project_codex_config = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "project-codex-config" }
capability_discovery = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "capability-discovery" }
agents_bootstrap = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "agents-bootstrap" }
spm_readme = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "spm-readme" }
app_readme = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "app-readme" }

assert(errors, !File.exist?(repo_path("SKILL.md")), "root SKILL.md must not exist in the plugin-first layout")
assert(errors, !File.exist?(repo_path("agents/openai.yaml")), "root agents/openai.yaml must not exist in the plugin-first layout")
assert(errors, File.exist?(repo_path(PLUGIN_MANIFEST_PATH)), "plugin manifest must exist at #{PLUGIN_MANIFEST_PATH}")
assert(errors, File.exist?(repo_path(MARKETPLACE_PATH)), "repo-local marketplace must exist at #{MARKETPLACE_PATH}")

assert(errors, plugin_manifest["name"] == PLUGIN_NAME, "plugin manifest name must be #{PLUGIN_NAME}")
assert(errors, plugin_manifest["skills"] == "./skills/", "plugin manifest must point skills to ./skills/")
assert(errors, plugin_manifest.dig("interface", "displayName") == "Apple Platform Setup", "plugin manifest must expose the Apple Platform Setup display name")

marketplace_entry = (marketplace["plugins"] || []).find { |entry| entry["name"] == PLUGIN_NAME }
assert(errors, marketplace["name"] == "apple-platform-project-setup-marketplace", "marketplace name must be apple-platform-project-setup-marketplace")
assert(errors, !marketplace_entry.nil?, "marketplace must include the #{PLUGIN_NAME} plugin entry")
assert(errors, marketplace.dig("interface", "displayName") == "Apple Platform Setup", "marketplace display name must be Apple Platform Setup")
assert(errors, marketplace_entry && marketplace_entry.dig("source", "source") == "local", "marketplace plugin entry must use a local source")
assert(errors, marketplace_entry && marketplace_entry.dig("source", "path") == "./plugins/#{PLUGIN_NAME}", "marketplace plugin entry must point to ./plugins/#{PLUGIN_NAME}")
assert(errors, marketplace_entry && marketplace_entry.dig("policy", "installation") == "AVAILABLE", "marketplace plugin entry must set installation to AVAILABLE")
assert(errors, marketplace_entry && marketplace_entry.dig("policy", "authentication") == "ON_INSTALL", "marketplace plugin entry must set authentication to ON_INSTALL")

PLUGIN_SKILLS.each do |skill_name|
  skill_dir = "#{PLUGIN_ROOT}/skills/#{skill_name}"
  skill_path = "#{skill_dir}/SKILL.md"
  openai_yaml_path = "#{skill_dir}/agents/openai.yaml"

  assert(errors, File.exist?(repo_path(skill_path)), "#{skill_name} must provide SKILL.md")
  assert(errors, File.exist?(repo_path(openai_yaml_path)), "#{skill_name} must provide agents/openai.yaml")

  next unless File.exist?(repo_path(skill_path)) && File.exist?(repo_path(openai_yaml_path))

  frontmatter, body = parse_frontmatter(skill_path)
  openai_yaml = YAML.load_file(repo_path(openai_yaml_path))
  interface = openai_yaml["interface"] || {}
  policy = openai_yaml["policy"] || {}

  assert(errors, frontmatter["name"] == skill_name, "#{skill_name} SKILL.md frontmatter name must match the directory name")
  assert(errors, frontmatter["description"].is_a?(String) && frontmatter["description"].start_with?("Use when"), "#{skill_name} description must start with 'Use when'")
  assert(errors, interface["display_name"].is_a?(String) && !interface["display_name"].empty?, "#{skill_name} agents/openai.yaml must define interface.display_name")
  assert(errors, interface["short_description"].is_a?(String) && !interface["short_description"].empty?, "#{skill_name} agents/openai.yaml must define interface.short_description")
  assert(errors, interface["default_prompt"].is_a?(String) && !interface["default_prompt"].empty?, "#{skill_name} agents/openai.yaml must define interface.default_prompt")

  if skill_name == ORCHESTRATION_SKILL
    assert(errors, policy.fetch("allow_implicit_invocation", true) == true, "the orchestration skill must remain implicit-capable")
    assert(errors, body.include?("Mandatory Execution Order"), "the orchestration skill must document the mandatory execution order")
    LEAF_SKILLS.each do |leaf_skill|
      assert(errors, body.include?("$#{leaf_skill}"), "the orchestration skill must reference #{leaf_skill} in its ordered flow")
    end
  else
    assert(errors, policy["allow_implicit_invocation"] == false, "#{skill_name} must disable implicit invocation")
    assert(errors, !body.include?("Mandatory Execution Order"), "#{skill_name} must not restate the full orchestration order")
  end
end

assert(errors, !project_codex_config.nil?, "catalog.yaml must define the project-codex-config artifact")
assert(errors, !capability_discovery.nil?, "catalog.yaml must define the capability-discovery artifact")
assert(errors, !agents_bootstrap.nil?, "catalog.yaml must define the agents-bootstrap artifact")
assert(errors, !spm_readme.nil?, "catalog.yaml must define the spm-readme artifact")
assert(errors, !app_readme.nil?, "catalog.yaml must define the app-readme artifact")

if project_codex_config
  config_profiles = project_codex_config["config_profiles"] || {}
  selection_hints = project_codex_config["selection_hints"] || []
  assert(errors, config_profiles["default_profile"] == "setup", "project-codex-config default profile must be setup")
  assert(errors, config_profiles["recommended_profiles"] == %w[setup review release], "project-codex-config recommended profiles must be setup/review/release")
  assert(errors, selection_hints.any? { |hint| hint.include?("vendored plugin skill path") }, "project-codex-config must describe vendored plugin skill registration")

  optional_hardening_keys = config_profiles["optional_hardening_keys"] || []
  %w[
    mcp_servers.<id>.enabled_tools
    mcp_servers.<id>.disabled_tools
    mcp_servers.<id>.required
    default_permissions
    permissions.<name>
    notify
    shell_environment_policy.*
  ].each do |key|
    assert(errors, optional_hardening_keys.include?(key), "project-codex-config optional hardening keys must include #{key}")
  end
end

if capability_discovery
  hints = capability_discovery["selection_hints"] || []
  assert(errors, hints.any? { |hint| hint.include?("Treat Superpowers as a plugin capability surface") }, "capability-discovery must treat Superpowers as a plugin capability surface")
end

if agents_bootstrap
  prerequisites = agents_bootstrap["prerequisites"] || []
  rendering = agents_bootstrap["agents_rendering"] || {}
  required_sections = rendering["require_exact_sections"] || []
  assert(errors, prerequisites.include?("capability_discovery_complete"), "agents-bootstrap must depend on capability_discovery_complete")
  assert(errors, required_sections.include?("Skill Usage Order"), "agents-bootstrap must require the Skill Usage Order section")
  assert(errors, rendering["skill_usage_order_line_format"] == "- Step <n>: Use $skill-name when <exact repository situation>.", "agents-bootstrap must define the exact skill usage order line format")
end

if spm_readme
  selection_hints = spm_readme["selection_hints"] || []
  assert(errors, spm_readme["target_path"] == "README.md", "spm-readme must target README.md")
  assert(errors, spm_readme["apply_mode"] == "generate_from_template", "spm-readme must use generate_from_template")
  assert(errors, selection_hints.any? { |hint| hint.include?("Do not infer Swift compiler support solely from `swift-tools-version`") }, "spm-readme must forbid inferring Swift support from swift-tools-version alone")
end

if app_readme
  selection_hints = app_readme["selection_hints"] || []
  assert(errors, app_readme["target_path"] == "README.md", "app-readme must target README.md")
  assert(errors, app_readme["apply_mode"] == "generate_from_template", "app-readme must use generate_from_template")
  assert(errors, selection_hints.any? { |hint| hint.include?("Never emit a placeholder App Store link") }, "app-readme must forbid placeholder App Store links")
end

release_doc = read_file("references/release-management.md")
assert(errors, release_doc.include?("release/x.y.z"), "release management doc must describe release/x.y.z branches")
assert(errors, release_doc.include?("vX.Y.Z"), "release management doc must describe vX.Y.Z tags")
assert(errors, release_doc.include?("GitHub Releases are the only changelog"), "release management doc must state GitHub Releases are the only changelog")
assert(errors, release_doc.include?("Do not use:"), "release management doc must include the non-default release constraints")
assert(errors, release_doc.include?("VERSION"), "release management doc must explicitly forbid VERSION files in the release baseline")
assert(errors, release_doc.include?("CHANGELOG.md"), "release management doc must explicitly forbid CHANGELOG.md in the release baseline")
assert(errors, release_doc.include?("plugins/apple-platform-project-setup/.codex-plugin/plugin.json"), "release management doc must require plugin manifest review")

codex_config_doc = read_file("references/codex-config.md")
%w[
  profile\ =\ \"setup\"
  [profiles.setup]
  [profiles.review]
  [profiles.release]
  approval_policy\ =\ \"on-request\"
  sandbox_mode\ =\ \"workspace-write\"
  web_search\ =\ \"cached\"
  web_search\ =\ \"live\"
  model_reasoning_effort\ =\ \"medium\"
  model_reasoning_effort\ =\ \"high\"
  plan_mode_reasoning_effort\ =\ \"high\"
].each do |token|
  assert(errors, codex_config_doc.include?(token.delete("\\")), "codex-config doc must include #{token.delete("\\")}")
end

assert(errors, codex_config_doc.include?('path = "plugins/apple-platform-project-setup/skills/apple-platform-project-setup-skill/SKILL.md"'), "codex-config doc must use the vendored plugin skill path")
assert(errors, codex_config_doc.include?("skip the local `[[skills.config]]` entry"), "codex-config doc must explain when local skill registration should be skipped")

%w[
  mcp_servers.<id>.enabled_tools
  mcp_servers.<id>.disabled_tools
  mcp_servers.<id>.required
  default_permissions
  permissions.<name>
  notify
  shell_environment_policy.*
].each do |token|
  assert(errors, codex_config_doc.include?(token), "codex-config doc must list #{token} as optional hardening")
end

%w[
  review_model
  model_provider
  openai_base_url
  telemetry
  analytics
].each do |token|
  assert(errors, codex_config_doc.include?(token), "codex-config doc must mention #{token} in the non-default guidance")
end

project_interview_doc = read_file("references/project-interview.md")
assert(errors, project_interview_doc.include?("setup` / `review` / `release`"), "project interview must mention the standard setup/review/release profile set")
assert(errors, project_interview_doc.include?("discovered_plugins"), "project interview must record discovered_plugins")
assert(errors, project_interview_doc.include?("Skill Usage Order"), "project interview must mention Skill Usage Order")
assert(errors, project_interview_doc.include?("concise library-style `README.md` baseline"), "project interview must ask about the SPM README baseline")
assert(errors, project_interview_doc.include?("app-first `README.md` baseline"), "project interview must ask about the app README baseline")

capability_doc = read_file("references/capability-discovery.md")
assert(errors, capability_doc.include?("obra/superpowers"), "capability-discovery doc must mention obra/superpowers explicitly")
assert(errors, capability_doc.include?("not a project-local skill install target"), "capability-discovery doc must forbid treating Superpowers as a project-local skill install target")

skill_verification_doc = read_file("references/skill-verification.md")
assert(errors, skill_verification_doc.include?("plugins/apple-platform-project-setup/.codex-plugin/plugin.json"), "skill-verification doc must mention the plugin manifest path")
assert(errors, skill_verification_doc.include?("repo-local marketplace"), "skill-verification doc must cover the repo-local marketplace")

github_actions_doc = read_file("references/github-actions.md")
%w[
  .build
  actions/cache/restore@v4
  actions/cache/save@v4
  --skip-build
].each do |token|
  assert(errors, github_actions_doc.include?(token), "github-actions doc must include #{token}")
end

spm_build_workflow = read_file("snippets/spm/workflows/build.yml")
%w[
  path:\ .build
  actions/cache/restore@v4
  actions/cache/save@v4
  github.event.pull_request.base.ref\ \|\|\ github.ref_name
  github.sha
  runner.debug\ !=\ '1'
  swift\ build\ --build-tests
].each do |token|
  assert(errors, spm_build_workflow.include?(token.delete("\\")), "spm build workflow must include #{token.delete("\\")}")
end

spm_test_workflow = read_file("snippets/spm/workflows/test.yml")
%w[
  path:\ .build
  actions/cache/restore@v4
  actions/cache/save@v4
  github.event.pull_request.base.ref\ \|\|\ github.ref_name
  github.sha
  runner.debug\ !=\ '1'
  swift\ build\ --build-tests
  swift\ test\ --skip-build\ --parallel
].each do |token|
  assert(errors, spm_test_workflow.include?(token.delete("\\")), "spm test workflow must include #{token.delete("\\")}")
end

readme = read_file("README.md")
assert(errors, readme.include?("plugins/apple-platform-project-setup/.codex-plugin/plugin.json"), "README must document the plugin manifest path")
assert(errors, readme.include?(".agents/plugins/marketplace.json"), "README must document the repo-local marketplace path")
assert(errors, readme.include?("codex plugin marketplace add inekipelov/apple-platform-project-setup-skill --ref main"), "README must document the one-line marketplace install command")
assert(errors, readme.include?("codex plugin marketplace add ."), "README must document the local marketplace install command")
assert(errors, readme.include?("release/x.y.z"), "README must mention release/x.y.z branches")
assert(errors, readme.include?("vX.Y.Z"), "README must mention vX.Y.Z tags")
assert(errors, readme.include?("GitHub Releases"), "README must mention GitHub Releases")

legacy_strings = [
  "npx skills add inekipelov/apple-platform-project-setup-skill",
  "npx skills add https://github.com/inekipelov/apple-platform-project-setup-skill -a codex",
  ".codex/skills/apple-platform-project-setup-skill",
  "[SKILL.md](./SKILL.md)"
]

%w[
  README.md
  references/codex-config.md
].each do |relative_path|
  content = read_file(relative_path)
  legacy_strings.each do |legacy_string|
    assert(errors, !content.include?(legacy_string), "#{relative_path} must not reference legacy root-skill packaging: #{legacy_string}")
  end
end

spm_readme_doc = read_file("references/spm-readme.md")
assert(errors, spm_readme_doc.include?("Do not infer Swift compiler support solely from `swift-tools-version`."), "spm-readme doc must forbid inferring Swift support from swift-tools-version")
assert(errors, spm_readme_doc.include?("Do not invent convenience APIs"), "spm-readme doc must forbid invented API surface")

spm_readme_template = read_file("snippets/spm/README.md")
%w[
  #\ <PackageName>
  ##\ Usage
  ##\ Installation
  <SupportedPlatformBadges>
].each do |token|
  assert(errors, spm_readme_template.include?(token.delete("\\")), "spm README template must include #{token.delete("\\")}")
end

app_readme_doc = read_file("references/app-readme.md")
assert(errors, app_readme_doc.include?("Never emit a placeholder App Store link."), "app-readme doc must forbid placeholder App Store links")
assert(errors, app_readme_doc.include?("Do not include aspirational or optional future technologies."), "app-readme doc must forbid aspirational stack items")

app_readme_template = read_file("snippets/xcode/README.md")
%w[
  #\ <AppName>
  ##\ Technical\ Stack
  ##\ Documentation
  <AppStoreLink>
  <SupportedPlatformBadges>
].each do |token|
  assert(errors, app_readme_template.include?(token.delete("\\")), "app README template must include #{token.delete("\\")}")
end

release_config = YAML.load_file(repo_path(".github/release.yml"))
categories = release_config.dig("changelog", "categories") || []
expected_categories = {
  "Breaking Changes" => ["breaking"],
  "Contract" => ["contract"],
  "Documentation" => ["docs"],
  "CI" => ["ci"],
  "Lint" => ["lint"],
  "Skills" => ["skills"],
  "MCP" => ["mcp"],
  "Release" => ["release"]
}

expected_categories.each do |title, labels|
  category = categories.find { |entry| entry["title"] == title }
  assert(errors, !category.nil?, ".github/release.yml must include the #{title} category")
  assert(errors, category && category["labels"] == labels, ".github/release.yml must map #{title} to #{labels.join(', ')}")
end

release_workflow = read_file(".github/workflows/prepare-release.yml")
assert(errors, release_workflow.include?("workflow_dispatch"), "prepare-release workflow must use workflow_dispatch")
assert(errors, release_workflow.include?("release/${VERSION}"), "prepare-release workflow must validate release/x.y.z branch naming")
assert(errors, release_workflow.include?("gh release create"), "prepare-release workflow must create a GitHub Release draft")

validate_workflow = read_file(".github/workflows/validate-repo-contract.yml")
assert(errors, validate_workflow.include?("pull_request"), "validate-repo-contract workflow must run on pull_request")
assert(errors, validate_workflow.include?("workflow_dispatch"), "validate-repo-contract workflow must allow manual dispatch")
assert(errors, validate_workflow.include?("ruby scripts/verify-repo-contract.rb"), "validate-repo-contract workflow must run the shared contract verification script")

if errors.empty?
  puts "CONTRACT_OK"
else
  errors.each { |message| warn "ERROR: #{message}" }
  exit 1
end
