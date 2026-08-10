{ pkgs, ... }:
{
	opts = {
		guifont = null;
	};

	extraConfigLua = ''
		local change_scale_factor = function(delta)
			vim.g.neovide_scale_factor = math.max(0.5, (vim.g.neovide_scale_factor or 1.0) + delta)
		end

		vim.keymap.set({ "n", "i" }, "<C-=>", function() change_scale_factor(0.1) end)
		vim.keymap.set({ "n", "i" }, "<C-->", function() change_scale_factor(-0.1) end)
		vim.keymap.set({ "n", "i" }, "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end)

		-- ClearType-style text: subpixel AA needs explicit pixel geometry
		vim.g.neovide_pixel_geometry = "RGBH"
		vim.g.neovide_text_gamma = 0.8
		vim.g.neovide_text_contrast = 0.1

		vim.g.neovide_cursor_short_animation_length = 0.02
		vim.g.neovide_position_animation_length = 0.1

		vim.g.neovide_cursor_animation_length = 0.05
		vim.g.neovide_cursor_trail_size = 0.05
		vim.g.neovide_cursor_antialiasing = true
		vim.g.neovide_cursor_vfx_mode = ""
		vim.g.neovide_floating_blur_amount_x = 2
		vim.g.neovide_floating_blur_amount_y = 2
		vim.g.neovide_hide_mouse_when_typing = true
		vim.g.neovide_remember_window_size = true
		vim.g.neovide_scroll_animation_length = 0.1
		vim.g.neovide_opacity = 0.98
		'';
}
