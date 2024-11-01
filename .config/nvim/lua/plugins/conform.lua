-- Customize conform.nvim
---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ruby = { "rubocop", stop_after_first = true },
    },
  },
}
