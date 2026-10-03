--[[
  RASP Versioning Module
  
  Handles project versioning logic:
  - Parse current version from project name/path
  - Generate new version number
  - Create versioned copy of project with all media
]]--

local versioning = {}

-- Load dependencies (will be available after require in main script)
local config = require("config")
local file_ops = require("file_operations")

-- Get current project information
function versioning.get_project_info()
  -- Get current project
  local proj, proj_path = reaper.EnumProjects(-1)
  
  if not proj_path or proj_path == "" then
    return nil, "No project loaded"
  end
  
  proj_path = file_ops.normalize_path(proj_path)
  
  local proj_dir = file_ops.get_directory(proj_path)
  local proj_filename = file_ops.get_filename(proj_path)
  local proj_basename = file_ops.get_basename(proj_path)
  local proj_ext = file_ops.get_extension(proj_path)
  
  -- Parse version from project name
  local current_version = config.parse_version(proj_basename)
  
  -- Get base name without version suffix
  local base_name = proj_basename
  if current_version then
    base_name = config.strip_version_suffix(proj_basename) or proj_basename
  end
  
  -- Get parent directory (where versioned folders are created)
  local parent_dir = file_ops.get_directory(proj_dir)
  
  -- If parent_dir is nil (project at root level or no parent available),
  -- use proj_dir itself to create versions in the same directory as the project file
  if not parent_dir or parent_dir == "" then
    parent_dir = proj_dir
  end
  
  return {
    project = proj,
    full_path = proj_path,
    directory = proj_dir,
    parent_directory = parent_dir,
    filename = proj_filename,
    basename = proj_basename,
    base_name = base_name,
    extension = proj_ext,
    current_version = current_version,
  }
end

-- Find highest existing version in parent directory
function versioning.find_highest_version(parent_dir, base_name)
  -- Return 0 if parent_dir is invalid (no existing versions can be found)
  if not parent_dir then return 0 end
  
  local highest = 0
  
  local i = 0
  while true do
    local subdir = reaper.EnumerateSubdirectories(parent_dir, i)
    if not subdir then break end
    
    -- Directory must be exactly base name + version suffix
    -- (a prefix match would count e.g. MyProjectExtra_v005 as a MyProject version)
    if subdir:sub(1, #base_name) == base_name then
      if config.strip_version_suffix(subdir) == base_name then
        local version = config.parse_version(subdir)
        if version and version > highest then
          highest = version
        end
      end
    end
    
    i = i + 1
  end
  
  return highest
end

-- Generate next version number
function versioning.get_next_version(info)
  if info.current_version then
    -- Project already has version, increment it
    return info.current_version + 1
  else
    -- New project, find highest existing version or start fresh
    local highest = versioning.find_highest_version(info.parent_directory, info.base_name)
    if highest > 0 then
      return highest + 1
    else
      return config.get("start_version")
    end
  end
end

-- Handle version folder conflict (#27)
-- Returns: resolved_path, resolved_folder_name, or nil if user cancelled
local function handle_version_conflict(target_path, version_name, info, next_version)
  local msg = string.format(
    "Folder '%s' already exists!\n\nChoose action:\n" ..
    "YES = Increment version number (use next available)\n" ..
    "NO = Overwrite existing folder\n" ..
    "CANCEL = Do nothing",
    version_name
  )

  local result = reaper.ShowMessageBox(msg, "RASP - Version Conflict", 3)

  if result == 6 then
    local try_version = next_version
    while try_version <= 999 do
      local try_suffix = config.format_version(try_version)
      local try_name = info.base_name .. try_suffix
      local try_path = file_ops.join_path(info.parent_directory, try_name)
      if not file_ops.dir_exists(try_path) then
        return try_path, try_name
      end
      try_version = try_version + 1
    end
    return nil
  elseif result == 7 then
    return target_path, version_name
  else
    return nil
  end
end

-- Create a new versioned copy of the project (auto mode)
-- Uses Main_SaveProjectEx flag 3 = flag 1 (create subdirectory)
--                          + flag 2 (copy all media into project dir)
-- Reaper creates the folder, copies all media, saves the .rpp and
-- rewrites internal path references atomically.
-- Do NOT pre-create the directory: flag 1 requires Reaper to create it.
function versioning.create_new_version_auto()
  local info, err = versioning.get_project_info()
  if not info then
    return false, err or "No project loaded"
  end
  
  local next_version = versioning.get_next_version(info)
  local version_suffix = config.format_version(next_version)
  local new_folder_name = info.base_name .. version_suffix
  local new_folder_path = file_ops.join_path(info.parent_directory, new_folder_name)
  
  -- Conflict handling (#27): ask the user when the target folder exists
  if file_ops.dir_exists(new_folder_path) then
    local resolved_path, resolved_name = handle_version_conflict(
      new_folder_path, new_folder_name, info, next_version
    )
    if not resolved_path then
      return false, "Operation cancelled"
    end
    new_folder_path = resolved_path
    new_folder_name = resolved_name
  end
  
  local new_rpp_name = new_folder_name .. ".rpp"
  local new_rpp_path = file_ops.normalize_path(
    file_ops.join_path(new_folder_path, new_rpp_name)
  )
  
  reaper.Main_SaveProjectEx(info.project, new_rpp_path, 3)
  
  -- Main_SaveProjectEx returns void; verify by checking the file exists
  if not file_ops.file_exists(new_rpp_path) then
    return false, "Save failed: " .. new_rpp_path
  end
  
  return true, string.format("Version %s created", new_folder_name)
end

-- Create a new version, mode determined by config (#26)
-- "native" opens Reaper's Save As dialog; "auto" versions programmatically
function versioning.create_new_version(mode)
  mode = mode or config.get("versioning_mode") or "auto"
  
  if mode == "native" then
    reaper.Main_OnCommand(40022, 0)
    return true, "Save As dialog opened"
  end
  
  return versioning.create_new_version_auto()
end

-- Get display string for current version
function versioning.get_version_display()
  local info, err = versioning.get_project_info()
  if not info then
    return "No project loaded"
  end
  
  if info.current_version then
    return string.format("v%d", info.current_version)
  else
    return "Not versioned"
  end
end

-- Get display string for project name
function versioning.get_project_display()
  local info, err = versioning.get_project_info()
  if not info then
    return "No project loaded"
  end
  
  return info.base_name
end

return versioning
