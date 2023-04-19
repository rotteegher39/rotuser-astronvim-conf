return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main",       -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "kanagawa-dragon",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    setup_handlers = {
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end
    },
    formatting = {
      format_on_save = {
        enabled = true, -- enable format on save
        ignore_filetypes = { -- disable format on save for specified filetypes
          "lua",
          "markdown",
          "python",
        }
      },
    },
  },
  plugins = {
    { "simrat39/rust-tools.nvim",
    opts = {
      tools = { -- rust-tools options
      -- These apply to the default RustSetInlayHints command
      inlay_hints = {
        -- automatically set inlay hints (type hints)
        -- default: true
        auto = true,

        -- Only show inlay hints for the current line
        only_current_line = false,

        -- whether to show parameter hints with the inlay hints or not
        -- default: true
        show_parameter_hints = true,

        -- prefix for parameter hints
        -- default: "<-"
        parameter_hints_prefix = "<- ",

        -- prefix for all the other hints (type, chaining)
        -- default: "=>"
        other_hints_prefix = "=> ",

        -- whether to align to the length of the longest line in the file
        max_len_align = false,

        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,

        -- whether to align to the extreme right or not
        right_align = false,

        -- padding from the right if right_align is true
        right_align_padding = 7,

        -- The color of the hints
        highlight = "Type",
      },
      hover_actions = {
        -- the border that is used for the hover window
        -- see vim.api.nvim_open_win()
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

        -- Maximal width of the hover window. Nil means no max.
        max_width = nil,

        -- Maximal height of the hover window. Nil means no max.
        max_height = nil,

        -- whether the hover action window gets automatically focused
        -- default: false
        auto_focus = true,
      },
    },
  },
},
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "rust_analyzer" },
      },
    },
    {"DingDean/wgsl.vim"},
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin", "matchparen" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
