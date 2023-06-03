return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust", enabled = true },
  -- { "rust-tools.nvim", opts = {
  --     tools = { -- rust-tools options
  --     reload_workspace_from_cargo_toml = true,
  --     inlay_hints = {
  --       auto = true,
  --       only_current_line = false,
  --       show_parameter_hints = true,
  --       highlight = "Cursor",
  --     },
  --     hover_actions = {
  --       border = {
  --         { "╒", "FloatBorder" },
  --         { "═", "FloatBorder" },
  --         { "╕", "FloatBorder" },
  --         { "│", "FloatBorder" },
  --         { "╛", "FloatBorder" },
  --         { "─", "FloatBorder" },
  --         { "╘", "FloatBorder" },
  --         { "│", "FloatBorder" },
  --       },
  --       auto_focus = true,
  --     },
  --   },
  --   }
  -- },
}
