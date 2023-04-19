return function(_, opts)
  local notify = require "notify"
  notify.setup({ background_colour = "#ffffff", })
  vim.notify = notify
end
