# RASP Installation Guide

## Requirements

### Required
- **Reaper DAW** v6.0 or newer (tested with v7.x)
- **Operating System**: Linux (Debian) — Windows and macOS are not supported and not planned

### Not required

No Reaper extensions (e.g. SWS) or other software are needed. RASP uses only
Reaper's built-in ReaScript API and the standard Unix `cp` command available
on Debian by default.

## Installation Steps

### 1. Locate Reaper Scripts Folder

In Reaper, go to:
- **Options** → **Show REAPER resource path in file manager**

This opens your Reaper resource folder. On Debian this is typically `~/.config/REAPER`.
Navigate to the `Scripts` subfolder (create it if it doesn't exist).

### 2. Get the RASP Files

Either clone the repository or download it as a ZIP:

```bash
git clone https://github.com/Zesseth/RASP.git
# or download: GitHub page → Code → Download ZIP, then unzip
```

You need the `RASP/` folder from the repository root.

### 3. Copy RASP Files

Copy the entire `RASP` folder into the `Scripts` directory:

```
REAPER/
└── Scripts/
    └── RASP/
        ├── RASP.lua
        └── modules/
            ├── config.lua
            ├── file_operations.lua
            ├── gui.lua
            └── versioning.lua
```

### 4. Load Script in Reaper

1. Open Reaper
2. Open the **Actions** menu (shortcut: `?` or `Shift+/`)
3. Click **"Load..."** or **"New action" → "Load ReaScript..."**
4. Navigate to `Scripts/RASP/RASP.lua`
5. Select it and click **Open**

### 5. Add Keyboard Shortcut (Optional)

1. In the Actions window, find "Script: RASP.lua"
2. Select it and click **"Add..."** to assign a keyboard shortcut
3. Recommended: `Ctrl+Alt+V` for quick version creation

### 6. Add to Toolbar (Optional)

1. Right-click any toolbar
2. Choose **Customize toolbar...**
3. Find "Script: RASP.lua" in the actions list
4. Drag it to your toolbar

## Usage

### Creating a New Version

1. Open a project in Reaper
2. Launch RASP (via Actions menu, shortcut, or toolbar)
3. Click **"Create New Version"**

RASP will:
- Create a new folder with incremented version number
- Copy ALL project files to the new folder
- Save the project with the new version name
- Switch to the new version automatically

### Version Naming

Projects are versioned as:
```
ProjectName_v001/ProjectName_v001.rpp
ProjectName_v002/ProjectName_v002.rpp
ProjectName_v003/ProjectName_v003.rpp
```

### First Version

If your project isn't versioned yet, RASP will:
- Detect the project name (e.g., `MySong.rpp`)
- Create `MySong_v001/MySong_v001.rpp`
- Copy all media to the new folder

## Configuration

Settings are stored in Reaper's ExtState and persist across sessions:

| Setting | Default | Description |
|---------|---------|-------------|
| `version_prefix` | `_v` | Text before version number |
| `version_digits` | `3` | Number of digits (e.g., 001) |
| `start_version` | `1` | First version number |

To modify (advanced):
```lua
-- In Reaper's ReaScript console
reaper.SetExtState("RASP", "version_prefix", "_ver", true)
reaper.SetExtState("RASP", "version_digits", "4", true)
```

## Troubleshooting

### "No project loaded"
- Make sure you have a project open in Reaper
- Save your project at least once before using RASP

### Files not copying
- Check write permissions on the destination folder
- Ensure enough disk space is available
- Verify the `cp` command is available (standard on Debian)

### Window doesn't dock
- The RASP window can be docked by dragging it to a dock area
- Window position and dock state are saved automatically

## Uninstallation

1. Remove `Scripts/RASP/` folder
2. In Reaper Actions, right-click the RASP action and remove it
3. (Optional) Clear settings:
   ```lua
   reaper.DeleteExtState("RASP", "version_prefix", true)
   reaper.DeleteExtState("RASP", "version_digits", true)
   reaper.DeleteExtState("RASP", "start_version", true)
   reaper.DeleteExtState("RASP", "window_dock", true)
   reaper.DeleteExtState("RASP", "window_x", true)
   reaper.DeleteExtState("RASP", "window_y", true)
   reaper.DeleteExtState("RASP", "window_width", true)
   reaper.DeleteExtState("RASP", "window_height", true)
   ```

## Future Versions

- **v0.2**: Safe versioning, Native/Auto mode, conflict handling, local archiving with archiving UI
- **v0.3**: Archive to Backblaze B2 and restore from B2
- **v0.4**: Media folder configuration, project discovery, per-project archive selection
