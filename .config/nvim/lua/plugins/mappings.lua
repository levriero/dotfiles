return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- normal mode
        n = {
          ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", desc = "Up Window" },
          ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", desc = "Down Window" },
          ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", desc = "Left Window" },
          ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", desc = "Right Window" },
        },
      },
    },
  },
}
