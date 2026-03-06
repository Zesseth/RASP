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
    local version_suffix = config.format_version(current_version)
    base_name = proj_basename:sub(1, -(#version_suffix + 1))
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
  local prefix = config.get("version_prefix")
  
  local i = 0
  while true do
    local subdir = reaper.EnumerateSubdirectories(parent_dir, i)
    if not subdir then break end
    
    -- Check if this directory matches our naming pattern
    if subdir:sub(1, #base_name) == base_name then
      local version = config.parse_version(subdir)
      if version and version > highest then
        highest = version
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

-- Create a new versioned copy of the project
function versioning.create_new_version()
  -- Get current project information
  local info, err = versioning.get_project_info()
  if not info then
    return false, err or "No project loaded"
  end

  -- Calculate next version number
  local next_version = versioning.get_next_version(info)

  -- Build version suffix (e.g. "_v001")
  local version_suffix = config.format_version(next_version)

  -- Build new folder name and path: {parent_dir}/{base_name}{version_suffix}/
  local new_folder_name = info.base_name .. version_suffix
  local new_folder_path = file_ops.join_path(info.parent_directory, new_folder_name)
  new_folder_path = file_ops.normalize_path(new_folder_path)

  -- Build new project file path: {new_folder}/{base_name}{version_suffix}.rpp
  -- info.extension already includes the leading dot (e.g. ".rpp"); fall back to ".rpp" if empty
  local ext = (info.extension and info.extension ~= "") and info.extension or ".rpp"
  local new_project_filename = new_folder_name .. ext
  local new_project_path = file_ops.join_path(new_folder_path, new_project_filename)
  new_project_path = file_ops.normalize_path(new_project_path)

  -- Warn if destination file already exists
  if file_ops.file_exists(new_project_path) then
    return false, "Version already exists: " .. new_folder_name
  end

  -- Create the destination directory
  if not file_ops.create_directory(new_folder_path) then
    return false, "Could not create directory: " .. new_folder_path
  end

  -- Save project to new path with flag 2 (copy all media into project directory)
  -- Reaper's engine handles .rpp save, media copying, and updating internal references
  local saved = reaper.Main_SaveProjectEx(nil, new_project_path, 2)
  if not saved then
    return false, "Main_SaveProjectEx reported failure saving to: " .. new_project_path
  end

  -- Verify the new project file was created
  if not file_ops.file_exists(new_project_path) then
    return false, "Save failed — project file not found after save: " .. new_project_path
  end

  return true, new_folder_name
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
