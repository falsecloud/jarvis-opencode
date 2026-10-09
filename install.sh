#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
VENV="$HOME/.local/share/jarvis/venv"

echo "==> system packages (portaudio, mpv, espeak-ng fallback)"
if   command -v apt-get >/dev/null; then sudo apt-get install -y python3-venv portaudio19-dev mpv espeak-ng ffmpeg
elif command -v pacman  >/dev/null; then sudo pacman -S --needed python portaudio mpv espeak-ng ffmpeg
elif command -v dnf     >/dev/null; then sudo dnf install -y python3 portaudio-devel mpv espeak-ng ffmpeg
elif command -v brew    >/dev/null; then brew install portaudio mpv espeak ffmpeg
else echo "Install manually: portaudio, mpv, espeak-ng, ffmpeg"; fi

echo "==> python venv"
python3 -m venv "$VENV"
"$VENV/bin/pip" install -U pip
"$VENV/bin/pip" install faster-whisper sounddevice numpy onnxruntime openwakeword edge-tts
"$VENV/bin/python" -c "import openwakeword; openwakeword.utils.download_models()" || \
  echo "(wake-word model download failed; use 'jarvis --ptt' or retry later)"

echo "==> opencode agent"
mkdir -p "$HOME/.config/opencode/agent"
cp "$HERE/agent/jarvis.md" "$HOME/.config/opencode/agent/jarvis.md"

echo "==> launcher"
mkdir -p "$HOME/.local/bin"
cp "$HERE/bin/jarvis" "$HOME/.local/bin/jarvis-voice.py"
printf '#!/usr/bin/env bash\nexec "%s/bin/python" "$HOME/.local/bin/jarvis-voice.py" "$@"\n' "$VENV" > "$HOME/.local/bin/jarvis"
chmod +x "$HOME/.local/bin/jarvis"

cat << 'MSG'

Done. Add this to ~/.config/kitty/kitty.conf for a hotkey that opens Jarvis in a split
in your current directory:

    map ctrl+shift+j launch --location=vsplit --cwd=current jarvis

Run `jarvis` (wake word "hey jarvis") or `jarvis --ptt` (press Enter to talk).
Interactive opencode with the persona:  opencode --agent jarvis
MSG
