--custom interface library

---@created by mikus
---- fatality crack 2022

















-------------------------------------------------------------------------------------

local _CLIPBOARDVERSION = 1.0

local str_len, str_tostring, ffi_str = string.len, tostring, ffi.string

local vgui_interface = ffi.cast(ffi.typeof("void***"), utils.find_interface("vgui2.dll", "VGUI_System010"))
local native_clipboardTextCount = ffi.cast("int(__thiscall*)(void*)", vgui_interface[0][7])
local native_clipboardSetText = ffi.cast("void(__thiscall*)(void*, const char*, int)", vgui_interface[0][9])
local native_clipboardGetText = ffi.cast("int(__thiscall*)(void*, int, const char*, int)", vgui_interface[0][11])
local char_array_type = ffi.typeof("char[?]")

local clipboard = {}

function clipboard.retrieve()
    local length = native_clipboardTextCount(vgui_interface)

    if length > 0 then
        local char_buffer = char_array_type(length)
        native_clipboardGetText(vgui_interface, 0, char_buffer, length)
        return ffi_str(char_buffer, length - 1)
    end
end

function clipboard.store(content)
    content = str_tostring(content)

    native_clipboardSetText(vgui_interface, content, str_len(content))
end

clipboard.paste = clipboard.retrieve
clipboard.copy = clipboard.store

return clipboard
