# RASP
Reaper Archiving System Project

A Lua plugin for Reaper DAW that provides automatic project versioning with full media backup.

## Features (v0.1)

- **Dockable UI** - Native Reaper interface
- **Auto-versioning** - Open save as dialog
- **Cross-platform** - Works on Linux (Debian) and Windows

## Requirements

### Required
- **Reaper DAW** v6.0 or newer (tested with v7.x)
- **Operating System**: Linux (Debian) or Windows 11 (tested)

### Recommended
No extensions or additonal needed.

## Project Structure

```
RASP/
├── RASP.lua              # Main entry point
├── modules/
│   ├── config.lua        # Settings & ExtState
│   ├── file_operations.lua   # File copying
│   ├── gui.lua           # User interface
│   └── versioning.lua    # Version logic
└── docs/
    └── installation.md   # Setup guide
```

## Quick Start

1. Copy `RASP/` folder to Reaper's `Scripts/` directory
2. In Reaper: Actions → Load ReaScript → Select `RASP.lua`
3. Run the script to open RASP window
4. Click "Create New Version" to version your project

See [installation guide](docs/installation.md) for detailed instructions.

## Version Format

```
MyProject/MyProject.rpp          → Original
MyProject_v001/MyProject_v001.rpp  → Version 1
MyProject_v002/MyProject_v002.rpp  → Version 2
```

---

## Roadmap

### Version 0.1 (in progress)
- RASP UI / plugin to Reaper
- Auto version from RASP UI
- Increment version number when versioning

### Version 0.2 (planned)
- Safe versioning: increment version and save automatically using Reaper's native save
- Native/Auto mode selection (Auto = fully automated, Native = opens Reaper's Save As dialog)
- Conflict handling when version folder already exists (overwrite / increment / do nothing)
- Archive current project versions to a local drive
- UI for archiving with configurable "versions to keep" count

### Version 0.3 (planned)
- Archive current project to Backblaze B2 cloud storage
- Restore project from Backblaze B2 archive

### Version 0.4 (planned)
- Configuration for Reaper media folder path
- Find all Reaper projects from configured media folder
- Select which projects to archive and how many versions to keep per project

### Future
- Additional cloud storage destinations (Amazon S3, Azure Blob Storage, Storj)
    
