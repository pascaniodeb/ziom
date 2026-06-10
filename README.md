# ZIOM

**Other AI agents write code.  
ZIOM decides if it should be written at all.**

<p align="center">
  <a href="#install"><img alt="Install" src="https://img.shields.io/badge/install-one%20command-black?style=for-the-badge"></a>
  <a href="#providers"><img alt="Providers" src="https://img.shields.io/badge/models-5%20providers-blue?style=for-the-badge"></a>
  <a href="#license"><img alt="License" src="https://img.shields.io/badge/CLI-MIT-green?style=for-the-badge"></a>
</p>

ZIOM is a coding agent for teams that want speed without handing architectural control to autocomplete.

It studies the request, weighs trade-offs, builds a plan, and only then moves toward code.

---

## Demo

> Demo GIF / asciicast coming soon.

```bash
ziom plan "build a REST API for user authentication"
```

Example output:

```text
ZIOM
Analyzing request...

✓ Architecture reviewed
✓ Security risks identified
✓ Performance constraints checked
✓ Cost and maintainability considered
✓ Implementation plan generated

Recommended direction:
  Build authentication as a small, isolated service boundary.
  Keep password handling, session lifecycle, and user profile updates separate.
  Add rate limits, input validation, and recovery flows before implementation.

Risks to address before code:
  - Account enumeration during login and password reset
  - Brute-force attempts against credential endpoints
  - Session invalidation across devices
  - Migration path for future social login

Next:
  ziom apply
```

---

## Why ZIOM

- **It plans before it writes.** Other AI coding agents optimize for first draft speed. ZIOM optimizes for decisions you can defend later.
- **It catches trade-offs early.** Security, performance, cost, and maintainability are considered before the first file changes.
- **It gets better inside your repo.** ZIOM learns the patterns, constraints, and recurring decisions in your codebase.

---

## Install

### macOS, Linux, Windows via WSL

```bash
curl -fsSL https://install.ziom.dev | sh
```

### Manual install

```bash
git clone https://github.com/pascaniodeb/ziom
cd ziom
./install.sh
```

Verify installation:

```bash
ziom --version
```

---

## Quickstart

```bash
ziom init
ziom plan "build a REST API for user authentication"
ziom apply
```

Expected first run:

```text
ZIOM initialized.

Project profile created.
Model provider detected.
Local rules loaded.
Ready.
```

After planning:

```text
Plan ready.

What ZIOM will do:
  1. Define the user-facing behavior.
  2. Identify risks and edge cases.
  3. Propose the smallest safe implementation path.
  4. Ask for confirmation before writing code.

Run:
  ziom apply
```

---

## Features

### Multi-model support

Use the provider that fits the task. Switch between fast, local, and frontier models without changing your workflow.

### Works offline

Use Ollama when you want local execution or need to work without network access.

### Learns from your codebase

ZIOM remembers project conventions, recurring patterns, and prior decisions so future work starts with context.

### Never writes code without a plan

Before modifying files, ZIOM explains the approach, risks, and expected outcome.

### Designed for real teams

Readable output. Clear next steps. No mystery diffs. No silent rewrites.

---

## Providers

<p>
  <img alt="Anthropic" src="https://img.shields.io/badge/Anthropic-Claude-black?style=for-the-badge">
  <img alt="Google Gemini" src="https://img.shields.io/badge/Google-Gemini-4285F4?style=for-the-badge&logo=google&logoColor=white">
  <img alt="Groq" src="https://img.shields.io/badge/Groq-fast%20inference-F55036?style=for-the-badge">
  <img alt="OpenRouter" src="https://img.shields.io/badge/OpenRouter-100%2B%20models-7C3AED?style=for-the-badge">
  <img alt="Ollama" src="https://img.shields.io/badge/Ollama-local-111111?style=for-the-badge">
</p>

Supported providers:

| Provider | Best for |
|---|---|
| Anthropic | Deep reasoning and careful planning |
| Google Gemini | Long-context analysis and embeddings |
| Groq | Fast iteration |
| OpenRouter | Broad model access |
| Ollama | Offline and local workflows |

---

## Requirements

ZIOM supports:

- macOS
- Linux
- Windows via WSL

You need:

- Git
- A POSIX-compatible shell
- At least one model provider key, or Ollama for local use

Optional:

- Ollama installed locally for offline mode

---

## Configuration

Create a `.env` file in your project root:

```bash
# Choose provider order
ZIOM_PROVIDER_ORDER=anthropic,gemini,groq,openrouter,ollama

# Cloud providers
ANTHROPIC_API_KEY=
GEMINI_API_KEY=
GROQ_API_KEY=
OPENROUTER_API_KEY=

# Local provider
OLLAMA_BASE_URL=http://localhost:11434

# Model behavior
ZIOM_LLM_TIMEOUT=120
```

Example local-only setup:

```bash
ZIOM_PROVIDER_ORDER=ollama
OLLAMA_BASE_URL=http://localhost:11434
```

Example fast cloud setup:

```bash
ZIOM_PROVIDER_ORDER=groq,gemini,anthropic
GROQ_API_KEY=...
GEMINI_API_KEY=...
ANTHROPIC_API_KEY=...
```

---

## Contributing

We're building in public.

Star the repo and watch for our first public release.

Discord: coming soon.  
Public social channel: coming soon.

---

## License

The ZIOM CLI is MIT licensed.

The core engine is proprietary.
