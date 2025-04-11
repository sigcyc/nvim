return {
  {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      }
    },
    {
      "williamboman/mason.nvim",
      opts = {}
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "lua_ls", "pyright"},
      }
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {'saghen/blink.cmp'},
      config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        require("lspconfig").lua_ls.setup{capabilities = capabilities}
        require("lspconfig").pyright.setup{capabilities = capabilities}
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
        vim.keymap.set("n", "K", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
      end
    }
  }
}
