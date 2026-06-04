[ru](../ru/proposal_ai_config_standard.md) | [ai-cli](https://github.com/johnthesmith/ai-cli)

---

# Proposal: Standardize AI Tool Directories

To reduce clutter in `$HOME` and provide a predictable layout for AI-related 
tools, I propose a simple convention based on XDG directories.

## Configuration

```text
~/.config/ai/
```

## Data

```text
~/.local/share/ai/
```

The `ai` directory acts as a common root for the AI ecosystem. Each tool stores 
its own files in a dedicated subdirectory.



### Example Structure

```text
~/.config/ai/
├── prompts/               # shared prompts
├── providers/             # provider definitions
├── mcp/                   # MCP configurations
├── <etc>/
└── app/
    ├── aichat/
    ├── codex/
    ├── claude/
    ├── cli/                # ai-cli
    └── <etc>               

~/.local/share/ai/
├── prompts/
├── cache/
├── memory/
├── <etc>
└── app/
    ├── aichat/
    ├── codex/
    ├── claude/
    ├── cli/
    └── <etc>/
```



## Benefits

* Reduces hidden directories in `$HOME`
* Provides a predictable location for AI-related resources
* Simplifies backup and migration
* Separates ecosystem-wide resources from tool-specific files
* Allows future interoperability without requiring a complex specification

The proposal intentionally defines only directory layout and naming conventions. 
File formats and internal structures remain the responsibility of individual 
tools.
