return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "Neotree",
  init = function() vim.g.neo_tree_remove_legacy_commands = true end,
  opts = function()
    -- TODO move after neo-tree improves (https://github.com/nvim-neo-tree/neo-tree.nvim/issues/707)
    local global_commands = {
      system_open = function(state) require("astronvim.utils").system_open(state.tree:get_node():get_id()) end,
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" or node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, seleect the next child
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else -- if not a directory just open it
          state.commands.open(state)
        end
      end,
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local results = {
          e = { val = modify(filename, ":e"), msg = "Extension only" },
          f = { val = filename, msg = "Filename" },
          F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
          h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
          p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
          P = { val = filepath, msg = "Absolute path" },
        }

        local messages = {
          { "\nChoose to copy to clipboard:\n", "Normal" },
        }
        for i, result in pairs(results) do
          if result.val and result.val ~= "" then
            vim.list_extend(messages, {
              { ("%s."):format(i), "Identifier" },
              { (" %s: "):format(result.msg) },
              { result.val, "String" },
              { "\n" },
            })
          end
        end
        vim.api.nvim_echo(messages, false, {})
        local result = results[vim.fn.getcharstr()]
        if result and result.val and result.val ~= "" then
          vim.notify("Copied: " .. result.val)
          vim.fn.setreg("+", result.val)
        end
      end,
    }
    local get_icon = require("astronvim.utils").get_icon
    return {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      source_selector = {
            winbar = true, -- toggle to show selector on winbar
            statusline = false, -- toggle to show selector on statusline
            show_scrolled_off_parent_node = true,                    -- boolean
            sources = {                                               -- table
                {
                    source = "filesystem",                            -- string
                    display_name = "  Files"                        -- string | nil
                },
                {
                    source = "buffers",                               -- string
                    display_name = " Buff"                         -- string | nil
                },
                {
                    source = "git_status",                            -- string
                    display_name = " Git"                          -- string | nil
                },
            },
            content_layout = "center",                                -- string
            tabs_layout = "equal",                                    -- string
            truncation_character = "…",                               -- string
            tabs_min_width = nil,                                     -- int | nil
            tabs_max_width = nil,                                     -- int | nil
            padding = 0,                                              -- int | { left: int, right: int }
            separator = { left = "▏", right= "▕" },                   -- string | { left: string, right: string, override: string | nil }
            separator_active = nil,                                   -- string | { left: string, right: string, override: string | nil } | nil
            show_separator_on_edge = false,                           -- boolean
            highlight_tab = "NeoTreeTabInactive",                     -- string
            highlight_tab_active = "NeoTreeTabActive",                -- string
            highlight_background = "NeoTreeTabInactive",              -- string
            highlight_separator = "NeoTreeTabSeparatorInactive",      -- string
            highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
      },
      default_component_configs = {
        indent = { padding = 0, indent_size = 1 },
        icon = {
          folder_closed = get_icon "FolderClosed",
          folder_open = get_icon "FolderOpen",
          folder_empty = get_icon "FolderEmpty",
          default = get_icon "DefaultFile",
        },
        modified = { symbol = get_icon "FileModified" },
        git_status = {
          symbols = {
            added = get_icon "GitAdd",
            deleted = get_icon "GitDelete",
            modified = get_icon "GitChange",
            renamed = get_icon "GitRenamed",
            untracked = get_icon "GitUntracked",
            ignored = get_icon "GitIgnored",
            unstaged = get_icon "GitUnstaged",
            staged = get_icon "GitStaged",
            conflict = get_icon "GitConflict",
          },
        },
      },
      window = {
        position = "right",
        width = 30,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          ["<S-l>"] = "next_source",
          o = "open",
          O = "system_open",
          h = "parent_or_close",
          l = "child_or_open",
          Y = "copy_selector",
        },
      },
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        commands = global_commands,
      },
      buffers = { commands = global_commands },
      git_status = { commands = global_commands },
      diagnostics = { commands = global_commands },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_) vim.opt_local.signcolumn = "auto" end,
        },
      },
    }
  end,
}
