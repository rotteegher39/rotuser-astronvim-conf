-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    -- Resize windows
    ["<A-h>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    ["<A-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    ["<A-k>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    ["<A-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>te"] = { function() require("astronvim.utils").toggle_term_cmd "evcxr" end, desc = "evcxr" },
    ["<leader>tC"] = {
      "<cmd>TermExec cmd='cargo clippy --fix --allow-dirty -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used -W clippy::expect_used'<cr>",
      desc = "Clippy --allow-dirty",
    },
    ["<leader>tc"] = {
      function() require("astronvim.utils").toggle_term_cmd "bacon check-all" end,
      desc = "Term Bacon",
    },
    ["<C-b>"] = { "<cmd>TermExec cmd='cargo run'<cr>", desc = "Cargo Run" },
    ["<leader>tg"] = { function() require("astronvim.utils").toggle_term_cmd "gdu" end, desc = "gdu" },
    ["<leader>tn"] = { function() require("astronvim.utils").toggle_term_cmd "ncdu" end, desc = "ncdu" },
    ["<leader>tT"] = { function() require("astronvim.utils").toggle_term_cmd "btm" end, desc = "btm" },
    ["<leader>tt"] = { function() require("astronvim.utils").toggle_term_cmd "bpytop" end, desc = "bpytop" },
    ["<leader>tp"] = { function() require("astronvim.utils").toggle_term_cmd "python" end, desc = "python" },
    ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Term float" },
    ["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Term horizontal split" },
    ["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Term vertical split" },
    ["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    --
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
    ["<f1>"] = false,
  },
}
