# Running GAMS from VS Code

This project has a VS Code task setup ([.vscode/tasks.json](.vscode/tasks.json)) that lets you compile/run GAMS
models directly from the editor, without opening the GAMS IDE separately. This works on any machine, as long as
GAMS is on the system PATH (see below).

## 1. Add GAMS to your PATH (Windows)

The tasks call GAMS by just running `gams`, so Windows needs to be able to find `gams.exe` on its own. Find your
GAMS install folder first — it's normally something like `C:\GAMS\50` (the folder that directly contains
`gams.exe`).

**GUI method:**
1. Press `Win`, type "environment variables", and open **"Edit environment variables for your account"**.
2. Under **User variables**, select `Path` → **Edit**.
3. Click **New** and add your GAMS folder, e.g. `C:\GAMS\50`.
4. Click OK on all dialogs.
5. **Restart VS Code** (and any open terminals) so it picks up the new PATH.

**PowerShell method (equivalent, run once):**
```powershell
[Environment]::SetEnvironmentVariable(
    "Path",
    $env:Path + ";C:\GAMS\50",
    "User"
)
```
Replace `C:\GAMS\50` with your actual install path/version.

**Verify it worked** — open a *new* terminal (old ones won't see the update) and run:
```powershell
gams --help
```
If you see GAMS's help output, the PATH is set up correctly.

## 2. Run a model from VS Code

Two tasks are defined:

| Task | What it runs | How |
|---|---|---|
| **GAMS: Run current file** | Whichever `.gms` file is open/active in the editor | `Ctrl+Shift+B` (default build task) |
| **GAMS: Run jordmod.gms** | Always runs the main model, `jordmod.gms`, regardless of what's open | **Terminal → Run Task…** → pick it from the list |

Output streams into VS Code's integrated terminal panel (`lo=3` tells GAMS to log there instead of only to a
listing file). The usual GAMS `.lst` listing file is still written next to the model file as normal.

## 3. Notes for other users on this project

- The tasks use the bare command `gams` (not a hardcoded path), so this works for everyone as long as step 1 is
  done — no need to edit `tasks.json` per machine or per GAMS version.
- If you have multiple GAMS versions installed, whichever one comes first in your PATH is the one VS Code will use.
- No VS Code extension is required for this to work; it's just running the GAMS executable as a build task. If you
  want `.gms` syntax highlighting, look for a GAMS extension in the VS Code marketplace — that's separate from,
  and not required for, the run/build task described here.
