--custom interface library

---@created by mikus
---- fatality crack 2022

















-------------------------------------------------------------------------------------

local _PUIVERSION = 1.1

local pui, gui_item = {}, {}

function pui.slider(name, path, min, max, step)
    return setmetatable({
        __item = gui.add_slider(name, path, min, max, step or 1),
        __path = path .. ">" .. name,
        __name = name,
        __item_type = "slider_t"
    }, gui_item)
end

function pui.ref(path, _type)
    return setmetatable({
        __item = gui.get_config_item(path),
        __path = path,
        __item_type = _type,
    }, gui_item)
end

function pui.switch(name, path)
    return setmetatable({
        __item = gui.add_checkbox(name, path),
        __path = path .. ">" .. name,
        __name = name,
        __item_type = "checkbox_t"
    }, gui_item)
end

function pui.keybind(name, path)
    return setmetatable({
        __item = gui.add_checkbox(name, path),
        __keybind = gui.add_keybind(path .. ">" .. name),
        __path = path .. ">" .. name,
        __name = name,
        __item_type = "keybind_t"
    }, gui_item)
end

function pui.listbox(name, path, items_to_show, search_bar, items)
    return setmetatable({
        __item = gui.add_listbox(name, path, items_to_show or 5, search_bar or false, items or {}),
        __path = path .. ">" .. name,
        __name = name,
        __item_type = "listbox_t"
    }, gui_item)
end

function pui.text(name, path)
    return setmetatable({
        __item = gui.add_listbox(name, path),
        __path = path .. ">" .. name,
        __name = name,
        __item_type = "textbox_t"
    }, gui_item)
end

function pui.combo(name, path, items)
    return setmetatable({
        __item = gui.add_combo(name, path, items),
        __path = path .. ">" .. name,
        __name = name,
        __items = {},
        __item_type = "combo_t"
    }, gui_item)
end

function pui.selector(name, path, _items)
    return setmetatable({
        __item = gui.add_multi_combo(name, path, _items),
        __path = path .. ">" .. name,
        __name = name,
        __items = _items,
        __item_type = "multi_combo_t"
    }, gui_item)
end

function pui.button(name, path, callback)
    return setmetatable({
        __item = { gui.add_button(name, path, callback) },
        __path = path .. ">" .. name,
        __name = name,
        __item_type = "button_t"
    }, gui_item)
end

gui_item.__index = gui_item

function gui_item:get_int()
    return gui.get_config_item(self.__path):get_int()
end

function gui_item:get_bool()
    return gui.get_config_item(self.__path):get_bool()
end

function gui_item:set_int(value)
    return gui.get_config_item(self.__path):set_int(value)
end

function gui_item:set_bool(value)
    return gui.get_config_item(self.__path):set_bool(value)
end

function gui_item:get_string()
    return gui.get_config_item(self.__path):get_string()
end

function gui_item:set_string(value)
    return gui.get_config_item(self.__path):set_string(value)
end

function gui_item:get_color()
    return gui.get_config_item(self.__path):get_color()
end

function gui_item:set_color(value)
    return gui.get_config_item(self.__path):set_color(value)
end

function gui_item:override(condition, value)
    override:system(self.__path, condition, { [self.__path] = value })
end

return pui