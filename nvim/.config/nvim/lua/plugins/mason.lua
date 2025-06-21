require("mason").setup{}
require("mason-lspconfig").setup{                             --autoinstall lsp
        ensure_installed = {"lua_ls","clangd"}}
