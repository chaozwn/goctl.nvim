# Goctl plugin for Neovim

> goctl is a manager tool for micro framework go-zero.

## Install goctl
```shell
GOPROXY=https://goproxy.cn/,direct go install github.com/zeromicro/go-zero/tools/goctl@latest
goctl env check -i -f -v
```

## Install

-- lazy.nvim
```lua
  {
    "chaozwn/goctl.nvim",
    ft = "goctl",
    enabled = vim.fn.executable "goctl" == 1,
    opts = function()
      local group = vim.api.nvim_create_augroup("GoctlAutocmd", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "goctl",
        callback = function()
          -- set up format keymap
          vim.keymap.set(
            "n",
            "<Leader>lf",
            "<Cmd>GoctlApiFormat<CR>",
            { silent = true, noremap = true, buffer = true, desc = "Format Buffer" }
          )
        end,
      })
    end,
  },
```

## Features

- Validate

> goctl valid when vim event "BufRead", "TextChanged", "TextChangedI".

- Format

use command `GoctlApiFormat` or lua

```lua
-- format when write file
vim.api.nvim_command("au BufWritePre *.api lua require('goctl.api').format()")
```

## Preview

<details>
    <summary>Code Diagnostic</summary>
    <img src="./images/goctl-diagnostic.gif" />
</details>

<details>
    <summary>Api Format</summary>
    <img src="./images/goctl-format.gif" />
</details>


