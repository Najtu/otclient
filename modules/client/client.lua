Client = {}

-- TODO: load and save configurations
function Client.init()
  -- set default settings
  g_window.show()
  g_window.setMinimumSize({ width = 550, height = 450 })

  -- initialize in fullscreen mode on mobile devices
  if g_window.getPlatformType() == "X11-EGL" then
    g_window.setFullscreen(true)
  else
    -- window size
    local size = { width = 800, height = 600 }
    size = Settings.getSize('window-size', size)
    g_window.resize(size)

    -- window position, default is the screen center
    local displaySize = g_window.getDisplaySize()
    local pos = { x = (displaySize.width - size.width)/2,
                  y = (displaySize.height - size.height)/2 }
    pos = Settings.getPoint('window-pos', size)
    g_window.move(pos)

    -- window maximized?
    local maximized = Settings.getBoolean('window-maximized', false)
    if maximized then g_window.maximize() end
  end

  g_window.setTitle('OTClient')
  g_window.setIcon(resolvepath('clienticon.png'))

  if not g_sprites.isLoaded() or not g_thingsType.isLoaded() then
    fatal("spr and dat files are not loaded, did you loaded them?")
  end
end

function Client.terminate()
  Settings.set('window-size', g_window.getUnmaximizedSize())
  Settings.set('window-pos', g_window.getUnmaximizedPos())
  Settings.set('window-maximized', g_window.isMaximized())
end
