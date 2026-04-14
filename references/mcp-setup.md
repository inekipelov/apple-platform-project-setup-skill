# MCP Setup

Use this document when the target repository should configure MCP integrations for Apple development.

## Official Sources

- Codex MCP config keys: <https://developers.openai.com/codex/config-reference#configtoml>
- Sosumi MCP and CLI docs: <https://sosumi.ai>
- Apple Xcode MCP bridge: <https://developer.apple.com/documentation/xcode/giving-external-agents-access-to-xcode>

## Recommended MCP: `sosumi` over HTTP

For Apple documentation lookup, prefer remote HTTP MCP:

```toml
[mcp_servers.sosumi]
url = "https://sosumi.ai/mcp"
```

This path does not require the `sosumi` CLI.

### Alternative: stdio proxy

Use the stdio proxy only when HTTP MCP is not a viable client path:

```toml
[mcp_servers.sosumi]
command = "npx"
args = ["-y", "mcp-remote", "https://sosumi.ai/mcp"]
```

## Xcode MCP: `xcrun mcpbridge`

This skill allows `xcode` MCP only for `xcode` workspaces.

Before configuring it:

1. Open the project in Xcode.
2. In Xcode, go to `Xcode > Settings > Intelligence`.
3. Turn on `Allow external agents to use Xcode tools`.

Apple-supported command:

```bash
codex mcp add xcode -- xcrun mcpbridge
```

Equivalent TOML shape:

```toml
[mcp_servers.xcode]
command = "xcrun"
args = ["mcpbridge"]
```

## Repo Policy

- `sosumi` MCP is valid for both `spm` and `xcode` workspaces.
- `xcode` MCP is valid only for `xcode` workspaces in this repo contract.
- Do not configure `xcode` MCP for `spm` workspaces in this skill.
- If the `xcode` workspace uses `Tuist`, run `tuist generate` first and open the generated project or workspace in Xcode before configuring `xcode` MCP.
- Do not require the `sosumi` CLI when the HTTP MCP path already works.
