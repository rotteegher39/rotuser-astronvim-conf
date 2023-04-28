return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust", enabled = true },
  { "rust-tools.nvim", opts = {
      tools = { -- rust-tools options
      inlay_hints = {
        only_current_line = true,
        highlight = "Type",
      },
      hover_actions = {
        border = {
          { "╒", "FloatBorder" },
          { "═", "FloatBorder" },
          { "╕", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╛", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╘", "FloatBorder" },
          { "│", "FloatBorder" },
        },
        auto_focus = true,
      },
    },
    }
  },
}
