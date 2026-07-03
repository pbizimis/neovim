-- Follow the current Omarchy theme's Neovim colorscheme.
--
-- Omarchy writes ~/.config/omarchy/current/theme/neovim.lua as a lazy.nvim
-- plugin spec whose LazyVim `opts` carry the colorscheme name. We don't use
-- LazyVim, so read that name ourselves and apply it. This makes Neovim match
-- whatever theme `omarchy theme set` selected.
--
-- M.apply() is re-runnable: called once at startup, and again by the Omarchy
-- theme-set hook (via the nvim server socket) so already-open instances switch
-- themes live. Setting the colorscheme fires the ColorScheme autocmd, which
-- re-applies transparency.
local M = {}

local function omarchy_colorscheme()
	local path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
	if vim.fn.filereadable(path) == 0 then
		return nil
	end
	local ok, spec = pcall(dofile, path)
	if not ok or type(spec) ~= "table" then
		return nil
	end
	for _, plugin in ipairs(spec) do
		if type(plugin) == "table" and plugin.opts and plugin.opts.colorscheme then
			return plugin.opts.colorscheme
		end
	end
	return nil
end

function M.apply()
	local scheme = omarchy_colorscheme() or "bamboo"
	pcall(vim.cmd.colorscheme, scheme)
end

M.apply()

return M
