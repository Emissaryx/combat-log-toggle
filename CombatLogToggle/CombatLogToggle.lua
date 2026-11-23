if not CombatLogToggle then CombatLogToggle = {} end
CombatLogToggle.Settings = CombatLogToggle.Settings or {}

local WINDOW = "CombatLogToggle"
local OPACITY_WINDOW = WINDOW .. "Opacity"
local OPACITY_SLIDER = OPACITY_WINDOW .. "Slider"
local DEFAULT_OPACITY = 0.9

function CombatLogToggle.Refresh()
	local enabled = TextLogGetEnabled("Combat")
	LabelSetText(WINDOW .. "Status", enabled and L"Enabled" or L"Disabled")
	LabelSetTextColor(WINDOW .. "Status", enabled and 0 or 255, enabled and 255 or 0, 0)
end

function CombatLogToggle.ApplyOpacity(opacity)
	opacity = tonumber(opacity) or DEFAULT_OPACITY
	opacity = math.max(0, math.min(1, opacity))
	CombatLogToggle.Settings.Opacity = opacity
	WindowSetAlpha(WINDOW .. "Background", opacity)
end

function CombatLogToggle.Initialize()
	CombatLogToggle.Settings.Opacity = tonumber(CombatLogToggle.Settings.Opacity) or DEFAULT_OPACITY
	CombatLogToggle.Settings.Locked = CombatLogToggle.Settings.Locked == true
	CreateWindow(WINDOW, true)
	CreateWindow(OPACITY_WINDOW, false)
	WindowSetTintColor(WINDOW .. "Background", 0, 0, 0)
	LabelSetTextColor(WINDOW .. "Title", 255, 200, 0)
	LabelSetText(WINDOW .. "Title", L"Combat Log")
	WindowSetMovable(WINDOW, not CombatLogToggle.Settings.Locked)
	CombatLogToggle.ApplyOpacity(CombatLogToggle.Settings.Opacity)
	CombatLogToggle.Refresh()
end

function CombatLogToggle.Toggle()
	if WindowGetShowing(OPACITY_WINDOW) then
		WindowSetShowing(OPACITY_WINDOW, false)
		return
	end
	TextLogSetEnabled("Combat", not TextLogGetEnabled("Combat"))
	CombatLogToggle.Refresh()
end

function CombatLogToggle.ShowContextMenu()
	if WindowGetShowing(OPACITY_WINDOW) then WindowSetShowing(OPACITY_WINDOW, false) end
	EA_Window_ContextMenu.CreateContextMenu(WINDOW, EA_Window_ContextMenu.CONTEXT_MENU_1, L"Combat Log")
	if CombatLogToggle.Settings.Locked then
		EA_Window_ContextMenu.AddMenuItem(L"Unlock", CombatLogToggle.ToggleLock, false, true)
	else
		EA_Window_ContextMenu.AddMenuItem(L"Lock", CombatLogToggle.ToggleLock, false, true)
	end
	EA_Window_ContextMenu.AddMenuItem(L"Set Opacity...", CombatLogToggle.ShowOpacity, false, true)
	EA_Window_ContextMenu.Finalize()
end

function CombatLogToggle.ToggleLock()
	CombatLogToggle.Settings.Locked = not CombatLogToggle.Settings.Locked
	WindowSetMovable(WINDOW, not CombatLogToggle.Settings.Locked)
end

function CombatLogToggle.ShowOpacity()
	LabelSetText(OPACITY_WINDOW .. "TitleBarText", L"Opacity")
	SliderBarSetCurrentPosition(OPACITY_SLIDER, CombatLogToggle.Settings.Opacity)
	WindowClearAnchors(OPACITY_WINDOW)
	WindowAddAnchor(OPACITY_WINDOW, "bottomleft", WINDOW, "topleft", 0, 2)
	WindowSetShowing(OPACITY_WINDOW, true)
end

function CombatLogToggle.OnOpacitySlide()
	CombatLogToggle.ApplyOpacity(SliderBarGetCurrentPosition(OPACITY_SLIDER))
end

function CombatLogToggle.CloseOpacity()
	WindowSetShowing(OPACITY_WINDOW, false)
end


