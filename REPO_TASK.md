# Task for opencode: publish this project to GitHub

You are inside the unzipped `jarvis-opencode` project. Do the following:

1. Run `git init -b main`, `git add -A`, and commit with the message
   "Initial commit: JARVIS voice agent for opencode".
2. Check `gh auth status`. If not logged in, stop and tell me to run `gh auth login`.
3. Create a public repo and push:
   `gh repo create jarvis-opencode --public --source=. --remote=origin --push \
     --description "Voice-controlled J.A.R.V.I.S. persona for opencode (wake word, STT, TTS)"`
4. Add topics: `gh repo edit --add-topic opencode --add-topic jarvis --add-topic voice-assistant --add-topic tts --add-topic whisper`
5. Delete this `REPO_TASK.md`, commit ("Remove setup task"), and push.
6. Reply with the repo URL.

Do not modify any other files. Do not run install.sh.
