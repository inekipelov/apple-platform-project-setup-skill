#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

ROOT = File.expand_path("..", __dir__)

def read_file(path)
  File.read(File.join(ROOT, path))
end

def assert(errors, condition, message)
  errors << message unless condition
end

errors = []

yaml_files = %w[
  catalog.yaml
  inventory/skills.yaml
  inventory/subagents.yaml
  agents/openai.yaml
  .github/release.yml
] + Dir.chdir(ROOT) do
  Dir[".github/workflows/*.{yml,yaml}"] + Dir["snippets/**/*.{yml,yaml}"]
end

yaml_files.each do |relative_path|
  YAML.load_file(File.join(ROOT, relative_path))
end

catalog = YAML.load_file(File.join(ROOT, "catalog.yaml"))
project_codex_config = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "project-codex-config" }
capability_discovery = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "capability-discovery" }
agents_bootstrap = catalog.fetch("artifacts").find { |artifact| artifact["artifact"] == "agents-bootstrap" }

assert(errors, !project_codex_config.nil?, "catalog.yaml must define the project-codex-config artifact")
assert(errors, !capability_discovery.nil?, "catalog.yaml must define the capability-discovery artifact")
assert(errors, !agents_bootstrap.nil?, "catalog.yaml must define the agents-bootstrap artifact")

if project_codex_config
  config_profiles = project_codex_config["config_profiles"] || {}
  assert(errors, config_profiles["default_profile"] == "setup", "project-codex-config default profile must be setup")
  assert(errors, config_profiles["recommended_profiles"] == %w[setup review release], "project-codex-config recommended profiles must be setup/review/release")

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

release_doc = read_file("references/release-management.md")
assert(errors, release_doc.include?("release/x.y.z"), "release management doc must describe release/x.y.z branches")
assert(errors, release_doc.include?("vX.Y.Z"), "release management doc must describe vX.Y.Z tags")
assert(errors, release_doc.include?("GitHub Releases are the only changelog"), "release management doc must state GitHub Releases are the only changelog")
assert(errors, release_doc.include?("Do not use:"), "release management doc must include the non-default release constraints")
assert(errors, release_doc.include?("VERSION"), "release management doc must explicitly forbid VERSION files in the release baseline")
assert(errors, release_doc.include?("CHANGELOG.md"), "release management doc must explicitly forbid CHANGELOG.md in the release baseline")

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

skill_doc = read_file("SKILL.md")
assert(errors, skill_doc.include?("references/capability-discovery.md"), "SKILL.md must reference capability-discovery.md")
assert(errors, skill_doc.include?("Skill Usage Order"), "SKILL.md must include the Skill Usage Order contract")
assert(errors, !skill_doc.include?("references/install-superpowers.md"), "SKILL.md must not reference install-superpowers.md")

readme = read_file("README.md")
assert(errors, readme.include?("release/x.y.z"), "README must mention release/x.y.z branches")
assert(errors, readme.include?("vX.Y.Z"), "README must mention vX.Y.Z tags")
assert(errors, readme.include?("GitHub Releases"), "README must mention GitHub Releases")

capability_doc = read_file("references/capability-discovery.md")
assert(errors, capability_doc.include?("obra/superpowers"), "capability-discovery doc must mention obra/superpowers explicitly")
assert(errors, capability_doc.include?("not a project-local skill install target"), "capability-discovery doc must forbid treating Superpowers as a project-local skill install target")

release_config = YAML.load_file(File.join(ROOT, ".github/release.yml"))
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
