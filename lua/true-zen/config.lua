local config = {}

config.options = {
    true_false_commands = false,
    cursor_by_mode = false,
	ui = {
		bottom = {
			-- set statusline not necessary
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = false,
			relativenumber = false,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 32,
			right_padding = 32,
			top_padding = 1,
			bottom_padding = 1,
			custome_bg = "",
			disable_bg_configuration = false,
			disable_fillchars_configuration = false,
			keep_default_fold_fillchars = true,
			force_hide_statusline = true,
			affected_higroups = {NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {}, StatusLineNC = {}, SignColumn = {}}
		},
		focus = {
			margin_of_error = 5,
			focus_method = "native"
		},
		minimalist = {
			store_and_restore_settings = true,
			show_vals_to_read = {}
		},
	},
	integrations = {
		galaxyline = false,
		vim_airline = false,
		vim_powerline = false,
		tmux = false,
		express_line = false,
		gitgutter = false,
		vim_signify = false,
		limelight = false,
		gitsigns = false,
		nvim_bufferline = true
	}
}

function config.set_options(opts)
    opts = opts or {}

    for opt, _ in pairs(opts) do
        -- check if option exists in the config's table
        if (config.options[opt] ~= nil) then -- not nil
            -- chec if option is a table
            if (type(opts[opt]) == "table") then -- if table
                for inner_opt, _ in pairs(opts[opt]) do
                    -- table contains element by that key
                    if (config.options[opt][inner_opt] ~= nil) then -- not nil
                        config.options[opt][inner_opt] = opts[opt][inner_opt]
                    end
                end
			else
                config.options[opt] = opts[opt]
            end
        end
    end
end

return config
