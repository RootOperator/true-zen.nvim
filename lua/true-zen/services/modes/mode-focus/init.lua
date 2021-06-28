local service = require("true-zen.services.modes.mode-focus.service")
local opts = require("true-zen.config").options

local cmd = vim.cmd

local M = {}

local function get_status()
    return status_mode_focus
end

local function set_status(value)
	status_mode_focus = value
end

local function on(focus_type)
    service.on()

	if (api.nvim_eval("winnr('$')") > 1) then
		if (focus_type == "experimental") then
			service.on("experimental")
		elseif (focus_type == "native") then
			service.on("native")
		end
	else
		print("TrueZen: You cannot focus the current window because there is only one")
	end

    set_status("on")
end

local function off(focus_type)
    service.off()

	if (focus_type == "experimental") then
		service.off("experimental")
	elseif (focus_type == "native") then
		service.off("native")
	end

    set_status("off")
end

local function toggle()
    if (get_status() == "on") then
        off()
    elseif (get_status() == "off") then
        on()
    else
        if (api.nvim_eval("winnr('$')") > 1) then
            local focus_method = opts["modes"]["focus"]["focus_method"]

            if (focus_method == "native") then
                local current_session_height = vim.api.nvim_eval("&co")
                local current_session_width = vim.api.nvim_eval("&lines")
                local total_current_session = tonumber(current_session_width) + tonumber(current_session_height)

                local current_window_height = vim.api.nvim_eval("winheight('%')")
                local current_window_width = vim.api.nvim_eval("winwidth('%')")
                local total_current_window = tonumber(current_window_width) + tonumber(current_window_height)

                difference = total_current_session - total_current_window

                for i = 1, tonumber(opts["modes"]["focus"]["margin_of_error"]), 1 do
                    if (difference == i) then -- since difference is small, it's assumable that window is focused
						off("native")
                        break
                    elseif (i == tonumber(opts["modes"]["focus"]["margin_of_error"])) then -- difference is too big, it's assumable that window is not focused
						on("native")
                        break
                    end
                end
            elseif (focus_method == "experimental") then
				on("experimental")
            end
        else
			print("TrueZen: You cannot focus the current window because there is only one")
        end
    end
end

function M.main(option)
    option = option or 0

    if (option == "toggle") then
        toggle()
    elseif (option == "on") then
        on()
    elseif (option == "off") then
        off()
    end
end

return M
