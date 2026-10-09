# jarvis-opencode

Turn [opencode](https://opencode.ai) into a voice-controlled J.A.R.V.I.S. Works great in kitty.

Say "hey jarvis", speak a request, and the agent works on your codebase and talks back.

```
mic -> wake word (openWakeWord) -> faster-whisper (local STT)
    -> opencode run --agent jarvis -> TTS (edge-tts / piper / espeak-ng)
```

## What's inside

| Path | Purpose |
| --- | --- |
| `agent/jarvis.md` | opencode agent: persona, spoken-output rules, permissions |
| `bin/jarvis` | Python voice loop (wake word or push-to-talk) |
| `install.sh` | Installs deps in a venv, the agent, and a `jarvis` launcher |

## Install

Clone and install in one go:

```bash
git clone https://github.com/falsecloud/jarvis-opencode.git && cd jarvis-opencode && bash install.sh
```

Add a kitty hotkey to `~/.config/kitty/kitty.conf`:

```
map ctrl+shift+j launch --location=vsplit --cwd=current jarvis
```

## Usage

```bash
jarvis            # wake word: "hey jarvis"
jarvis --ptt      # push-to-talk: press Enter, then speak
jarvis --fresh    # (reserved) start without continuing a session
opencode --agent jarvis   # use the persona in the normal TUI
```

Say "shut down" or "goodbye" to exit. Ctrl+C while it's speaking skips the rest of the reply.

## Configuration (env vars)

| Variable | Default | Notes |
| --- | --- | --- |
| `JARVIS_AGENT` | `jarvis` | opencode agent name |
| `JARVIS_MODEL` | (opencode default) | e.g. `anthropic/claude-sonnet-4-5` |
| `JARVIS_WHISPER` | `base.en` | `tiny.en`, `base.en`, `small.en`... |
| `JARVIS_VOICE` | `en-GB-RyanNeural` | edge-tts voice (needs internet) |
| `JARVIS_PIPER_MODEL` | unset | path to a piper `.onnx` for a fully offline voice |

## Notes

- Verify flags with `opencode run --help`; some versions use `~/.config/opencode/agents/` instead of `agent/`.
- Headless runs can't answer permission prompts, so `agent/jarvis.md` pre-allows most commands and denies `rm -rf`, `sudo`, `git push`. Edit to taste.
- `--continue` resumes your most recent opencode session, which may be a different window's.
- Mic too sensitive or deaf? Try `jarvis --threshold 500`.

## License

MIT
