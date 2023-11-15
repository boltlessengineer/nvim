return {
  {
    "robitx/gp.nvim",
    -- TODO: add command to read query-selected comment(using power of tree-sitter)
    -- `inoremap <c-g>` will run comment(or single line) above
    keys = {
      { "<c-g>", desc = "+chatgpt" },
      { "<c-g>n", "<cmd>tabnew|GpChatNew<cr>", desc = "New Chat" },
    },
    config = true,
  },
}
