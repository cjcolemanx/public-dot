local status, leap = pcall(require, "leap")

if not status then
  -- print("ERROR: plugin 'leap' is unavailable")
  return
end

leap.add_default_mappings()
leap.opts.case_sensitive = true
