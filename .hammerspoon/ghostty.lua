local M = {}

function M.openAtPath(path)
  if not path or path == "" then
    return
  end
  local basename = path:match("([^/]+)$")
  local ghostty = hs.application.get("Ghostty")
  if ghostty then
    local windows = ghostty:allWindows()
    for _, win in ipairs(windows) do
      local title = win:title()
      if title and basename and string.find(title, basename, 1, true) then
        win:focus()
        return
      end
    end
  end

  hs.execute(string.format("open -g -a Ghostty %s", path))

  hs.timer.doUntil(
    function()
      local ghostty = hs.application.get("Ghostty")
      if ghostty then
        local windows = ghostty:allWindows()
        for _, win in ipairs(windows) do
          local title = win:title()
          if title and basename and string.find(title, basename, 1, true) then
            return true
          end
        end
      end
      return false
    end,
    function()
      local ghostty = hs.application.get("Ghostty")
      if ghostty then
        local windows = ghostty:allWindows()
        for _, win in ipairs(windows) do
          local title = win:title()
          if title and basename and string.find(title, basename, 1, true) then
            win:focus()
            return
          end
        end
      end
    end,
    0.1
  )
end

return M
