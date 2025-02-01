local options = {
	number = true,
	relativenumber = false,
	wrap = false, --however long a line is,keep it within one line
	mouse = "a",  --allow mouse to be used in nvim
	cmdheight = 2,
	clipboard = "unnamedplus",
	cursorline = true,
	fileencoding = "utf-8",
	hlsearch = true,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	autoindent = true,
	termguicolors = true,
	signcolumn = "yes",
	ignorecase = true, --do not distinct capitalised character 
	smartcase = true,
	splitright = true,
	splitbelow = true,
	swapfile = false, -- 禁用交换文件
	backup = false,   -- 禁用文件备份
}
-- 用一个循环来设置基本参数
for key, value in pairs(options) do
	vim.opt[key] = value
end

-- 创建文件时自动加载c++模板头
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local template_path = vim.fn.stdpath("config")  .. "/template.cpp"
    if vim.fn.filereadable(template_path) == 1 then
      local content = vim.fn.readfile(template_path)
      vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
    end
  end
})

-- 键位映射

local k = vim.keymap
vim.g.mapleader = " "

-- Normal mode
-- Clear search highlights
k.set("n", "<leader>nh", ":nohl<CR>")

function CompileAndRun()
    vim.cmd("write")  -- 保存文件

    -- 获取当前文件的完整路径（带扩展名）
    local filepath = vim.fn.expand('%:p')  
    -- 获取当前文件的文件名（不带扩展名）作为输出文件名
    local output_name = vim.fn.expand('%:t:r')  -- 当前文件名（不带扩展名）

    -- 判断当前操作系统
    if vim.fn.has("unix") == 1 then
        -- Linux 或其他 Unix 系统
        local file_path = vim.fn.expand('%:p')
        local output_name = vim.fn.expand('%:p:r')
    
        -- 更改当前工作目录为文件所在目录
        vim.cmd("lcd " .. vim.fn.expand('%:p:h'))
    
        -- 构建编译命令
        local compile_cmd = string.format("g++ -std=c++20 \"%s\" -o \"%s\"", file_path, output_name)
        -- 构建运行命令
        local run_cmd = string.format("./%s", output_name:match("([^/]+)$"))
    
        -- 尝试编译并运行
        if vim.fn.system(compile_cmd) == "" then
            vim.cmd(string.format("vsplit | term bash -c \"%s\"", run_cmd))
        end
    elseif vim.fn.has("win32") == 1 then
        -- Windows 系统
        vim.cmd(string.format(
            "vsplit | term g++ \"%s\" -o \"%s\" && \"%s\"",
            filepath,  -- 源文件
            output_name,  -- 输出文件
            output_name  -- 运行输出文件
        ))
    end

    -- 打开终端后自动进入插入模式
    vim.cmd("startinsert")
end

vim.api.nvim_set_keymap('n', '<F5>', ':lua CompileAndRun()<CR>', { noremap = true, silent = true })
-- Tree
-- 切换 NvimTree 文件管理窗口
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Neogit
vim.api.nvim_set_keymap('n', '<C-g>', ':Neogit<CR>', { noremap = true, silent = true })

-- Competitivetest
-- 设置快捷键用于常见的 CompetitiveTest 操作
vim.api.nvim_set_keymap('n', 'ca', ':CompetiTest add_testcase<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'cr', ':CompetiTest run<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ce', ':CompetiTest edit_testcase<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ct', ':CompetiTest receive testcases<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'cp', ':CompetiTest receive problem<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'cc', ':CompetiTest receive contest<CR>', { noremap = true, silent = true })

-- 使用 Telescope 打开文件浏览器
vim.api.nvim_set_keymap('n', '<Leader>fb', ":Telescope file_browser<CR>", { noremap = true, silent = true })

-- 字体大小调整
local default_font_size = 12
local current_font_size = default_font_size

-- 设置字体大小的函数
local function set_font_size(size)
    vim.opt.guifont = string.format("FiraCode Nerd Font:h%d", size)
end

-- 增大字体大小的函数
local function increase_font_size()
    current_font_size = current_font_size + 1
    set_font_size(current_font_size)
end

-- 减小字体大小的函数
local function decrease_font_size()
    current_font_size = current_font_size - 1
    set_font_size(current_font_size)
end

-- 绑定快捷键用于增减字体大小
vim.api.nvim_set_keymap("n", "<C-+>", ":lua increase_font_size()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-=>", ":lua increase_font_size()<CR>", { noremap = true, silent = true }) -- 处理键盘布局不同情况
vim.api.nvim_set_keymap("n", "<C-->", ":lua decrease_font_size()<CR>", { noremap = true, silent = true })

-- 设置初始字体大小
set_font_size(default_font_size)


-- 使用 ctrl+A 复制所有到剪贴板
vim.api.nvim_set_keymap('n', '<C-Y>', 'ggVG"+y', { noremap = true })
-- 将 Ctrl + V 映射为粘贴剪贴板内容
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true })

-- 将 Ctrl + C 映射为复制当前选中的内容到剪贴板
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true })

-- 使用Lazy插件管理器
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- 导入插件列表
   -- { import = "plugins" },

    -- 插件配置：自动配对
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },

    -- 插件：Monokai 主题
    { "tanvirtin/monokai.nvim" },
    { "folke/tokyonight.nvim" },

    -- 插件：注释插件配置
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup({
          ft = {
            cpp = {
              line = '//%s',  -- C++ 行注释的格式
              block = '/*%s*/', -- C++ 块注释的格式
            },
          },
        })
      end,
    },

    -- 插件：Bufferline
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("bufferline").setup{}
      end,
    },

    -- 插件：Neogit
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",         -- 必需
        "sindrets/diffview.nvim",        -- 可选：Diff 集成
        "nvim-telescope/telescope.nvim", -- 可选：Telescope 集成
      },
      config = true
    },

    -- 插件：lualine
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- 配置 lualine
        local lualine = require("lualine")

        -- 简洁配置
        local config_minimal = {
          options = {
            theme = "auto",  -- 自动主题
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
          },
          sections = {
            lualine_a = { "mode" },                 -- 当前模式
            lualine_b = { "branch" },               -- Git 分支
            lualine_c = { "filename" },             -- 当前文件名
            lualine_x = { "filetype" },             -- 文件类型
            lualine_y = { "progress" },             -- 编辑进度
            lualine_z = { "location" },             -- 当前光标位置
          },
        }

        -- 应用配置
        lualine.setup(config_minimal)
      end,
    },
     {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup {
            update_focused_file = {
                enable = true,
                update_cwd = true, -- 切换目录时更新当前工作目录
            },
            sync_root_with_cwd = true, -- 同步 nvim-tree 根目录与全局 cwd
            respect_buf_cwd = true, -- 使 nvim-tree 尊重缓冲区的 cwd
            view = {
                width = 30,
                side = 'left',
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
                change_dir = {
                    enable = true,
                    global = true, -- 使用全局 cwd
                },
            },
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
        }
    end,
},
          {
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "cpp", "lua" },
                highlight = { 
                    enable = true,
                    additional_vim_regex_highlighting = { "cpp" },
                },
                indent = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
            }
        end,
    }
},
      -- Mason.nvim
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Mason Tool Installer
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "clang-format", -- C, C++
        "clangd",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 配置 Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", }, -- 自动安装的 LSP 服务器
      })

      -- 配置 LSP 诊断图标
      local signs = {
        Error = "",
        Warn = "",
        Info = "",
        Hint = "",
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
      end

      -- 配置 LSP 诊断高亮组
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#FF0000" })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarning", { fg = "#FFA500" })
      vim.api.nvim_set_hl(0, "DiagnosticSignInformation", { fg = "#00FF00" })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#0000FF" })

      -- 配置 LSP 客户端
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()


      -- 通用 LSP 配置
      local common_setup = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Lua LSP 配置
      lspconfig.lua_ls.setup(vim.tbl_extend("force", common_setup, {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- 忽略 `vim` 全局变量的未定义警告
            },
            telemetry = {
              enable = false, -- 禁用遥测
            },
          },
        },
      }))

      -- Clangd LSP 配置
      lspconfig.clangd.setup(common_setup)

    end,
  },
 {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- 延迟加载，仅在进入插入模式时加载
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP 补全源
    "hrsh7th/cmp-buffer", -- 缓冲区补全源
    "hrsh7th/cmp-cmdline", -- 命令行补全源
    "onsails/lspkind-nvim", -- 补全显示图标
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    -- 自定义 Tab 键行为
    local function tab(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end

    -- 自定义 Shift-Tab 键行为
    local function shift_tab(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end

    -- 设置 cmp
    cmp.setup({
      snippet = {
        expand = function(args)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(), -- 补全窗口带边框
        documentation = cmp.config.window.bordered(), -- 文档窗口带边框
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- 显示图标和文本
          maxwidth = 50, -- 最大宽度
          ellipsis_char = "...", -- 超出宽度时显示省略号
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动文档
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- 向下滚动文档
        ["<C-Space>"] = cmp.mapping.complete(), -- 触发补全
        ["<C-e>"] = cmp.mapping.abort(), -- 关闭补全
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 确认选择
        ["<Tab>"] = cmp.mapping(tab, { "i", "s" }), -- Tab 键选择下一个
        ["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s" }), -- Shift-Tab 键选择上一个
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP 补全
        { name = "buffer" }, -- 缓冲区补全
        { name = "path" }, -- 路径补全
      }),
      completion = {
        keyword_length = 2, -- 触发补全的最少字符数
        completeopt = "menu,menuone,noinsert", -- 补全选项
        max_item_count = 10, -- 补全列表的最大项数
      },
    })

    -- 针对 C++ 文件类型的补全配置
    cmp.setup.filetype("cpp", {
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP 补全
        { name = "buffer" }, -- 缓冲区补全
      }),
    })

    -- 命令行补全配置
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }, -- 缓冲区补全
      },
    })

  end,
},
         {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                -- 其他文件类型和格式化工具配置
            },
            formatters = {
                clang_format = {
                    exe = "clang-format",
                    args = function()
                        return {
                            "--assume-filename=" .. vim.fn.expand('%:p'),
                            [[--style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: Never, BreakBeforeBraces: Attach, ColumnLimit: 0}]]
                        }
                    end,
                    stdin = true
                }
            }
        })
        -- 设置快捷键来手动格式化代码
        vim.api.nvim_set_keymap('n', '<Leader>f', ':lua require("conform").format()<CR>', { noremap = true, silent = true })
    end,
},
    {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
        require('competitest').setup {
            local_config_file_name = ".competitest.lua",
            floating_border = "rounded",
            floating_border_highlight = "FloatBorder",
            
            picker_ui = {
                width = 0.2,
                height = 0.3,
                mappings = {
                    focus_next = { "j", "<down>", "<Tab>" },
                    focus_prev = { "k", "<up>", "<S-Tab>" },
                    close = { "<esc>", "<C-c>", "q", "Q" },
                    submit = { "<cr>" },
                },
            },
            
            editor_ui = {
                popup_width = 0.4,
                popup_height = 0.6,
                show_nu = true,
                show_rnu = false,
                normal_mode_mappings = {
                    switch_window = { "<C-h>", "<C-l>", "<C-i>" },
                    save_and_close = "<C-s>",
                    cancel = { "q", "Q" },
                },
                insert_mode_mappings = {
                    switch_window = { "<C-h>", "<C-l>", "<C-i>" },
                    save_and_close = "<C-s>",
                    cancel = "<C-q>",
                },
            },
            
            runner_ui = {
                interface = "split",  -- 可以选择 "popup" 或 "split"
                selector_show_nu = false,
                selector_show_rnu = false,
                show_nu = true,
                show_rnu = false,
                mappings = {
                    run_again = "R",
                    run_all_again = "<C-r>",
                    kill = "K",
                    kill_all = "<C-k>",
                    view_input = { "i", "I" },
                    view_output = { "a", "A" },
                    view_stdout = { "o", "O" },
                    view_stderr = { "e", "E" },
                    toggle_diff = { "d", "D" },
                    close = { "q", "Q" },
                },
                viewer = {
                    width = 0.5,
                    height = 0.5,
                    show_nu = true,
                    show_rnu = false,
                    close_mappings = { "q", "Q" },
                },
            },
            
            popup_ui = {
                total_width = 0.9,
                total_height = 0.9,
				layout = {
					{ 1, {
						{ 1, "so" },
						{ 1, {
							{ 2, "tc" },
							{ 1, "se" },
							} },
					} },
					{ 1, {
						{ 1, "eo" },
						{ 1, "si" },
					} },
				},
            },
            
            split_ui = {
                position = "left",
                relative_to_editor = true,
                total_width = 0.5,
                vertical_layout = {
                    { 1, "tc" },
                    { 1, { { 1, "so" }, { 1, "eo" } } },
                    { 1, { { 1, "si" }, { 1, "se" } } },
                },
                total_height = 0.4,
                horizontal_layout = {
                    { 2, "tc" },
                    { 3, { { 1, "so" }, { 1, "si" } } },
                    { 3, { { 1, "eo" }, { 1, "se" } } },
                },
            },
            
            save_current_file = true,
            save_all_files = false,
            compile_directory = ".",
            compile_command = {
                c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
                cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
                rust = { exec = "rustc", args = { "$(FNAME)" } },
                java = { exec = "javac", args = { "$(FNAME)" } },
            },
            running_directory = ".",
            run_command = {
                c = { exec = "./$(FNOEXT)" },
                cpp = { exec = "./$(FNOEXT)" },
                rust = { exec = "./$(FNOEXT)" },
                python = { exec = "python", args = { "$(FNAME)" } },
                java = { exec = "java", args = { "$(FNOEXT)" } },
            },
            multiple_testing = -1,
            maximum_time = 5000,
            output_compare_method = "squish",
            view_output_diff = false,
            
            testcases_directory = ".",
            testcases_use_single_file = false,
            testcases_auto_detect_storage = true,
            testcases_single_file_format = "$(FNOEXT).testcases",
            testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
            testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",
            
            companion_port = 27121,
            receive_print_message = true,
            template_file = false,
            evaluate_template_modifiers = false,
            date_format = "%c",
            received_files_extension = "cpp",
            received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)",
            received_problems_prompt_path = true,
            received_contests_directory = "$(CWD)",
            received_contests_problems_path = "$(PROBLEM).$(FEXT)",
            received_contests_prompt_directory = true,
            received_contests_prompt_extension = true,
            open_received_problems = true,
            open_received_contests = true,
            replace_received_testcases = false,
        }
    end,
},

    },
  -- 配置：插件安装和更新
  install = { colorscheme = { "habamax" } },  -- 默认安装的主题
  checker = { enabled = true },               -- 自动检查插件更新
})

-- 配置 LSP
require 'lspconfig'.clangd.setup {}  -- 启用 clangd 自动补全
require 'lspconfig'.lua_ls.setup {}  -- 启用 Lua LSP

vim.cmd([[colorscheme monokai_soda]])
--vim.cmd([[colorscheme tokyonight]])
