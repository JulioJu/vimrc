--  nvim-tree.lua {{{1
    -- A file explorer tree for neovim written in lua
    -- https://neovimcraft.com/plugin/kyazdani42/nvim-tree.lua

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- empty setup using defaults
    require("nvim-tree").setup()

    -- OR setup with some options
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
            git_ignored = true,
        },
    })

-- gitsigns.nvim {{{1
    -- https://github.com/lewis6991/gitsigns.nvim
    -- Git integration for buffers
    require('gitsigns').setup()

-- Fugitive gitlinker {{{1
    -- A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend hosts. Inspired by tpope/vim-fugitive's :GBrowse
    -- https://github.com/ruifm/gitlinker.nvim
    require"gitlinker".setup({
        opts = {
            remote = nil, -- force the use of a specific remote
            -- adds current line nr in the url for normal mode
            add_current_line_on_normal_mode = true,
            -- callback for what to do with the url
            action_callback = require"gitlinker.actions".copy_to_clipboard,
            -- print the url after performing the action
            print_url = true,
        },
        callbacks = {
            ["github.com"] = require"gitlinker.hosts".get_github_type_url,
        },
        -- default mapping to call url generation with action_callback
        mappings = "<leader>gy"
    })

-- Telescope {{{1
    -- https://github.com/nvim-telescope/telescope.nvim
    -- Find, Filter, Preview, Pick. All lua, all the time.
    -- https://github.com/fannheyward/telescope-coc.nvim
    require("telescope").setup({
        extensions = {
        coc = {
            theme = 'ivy',
            prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
            }
        },
        -- https://github.com/nvim-telescope/telescope.nvim/pull/828
        pickers = {
            buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
                i = {
                        ["<c-d>"] = "delete_buffer",
                    }
                }
            }
        }
    })
    require('telescope').load_extension('coc')


-- Treesitter {{{1
    -- Nvim Treesitter configurations and abstraction layer
    -- https://github.com/nvim-treesitter/nvim-treesitter
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

        ensure_installed = {
          "java",
          "kotlin",
          "groovy",

          "html",
          "jsdoc",
          "javascript",
          "typescript",
          "vue",
          "scss",
          "css",
          "tsx",

          -- "json",
          "jsonc",

          "yaml",
          "xml",

          "dockerfile",

          "diff",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",

          "lua",
          "vim",
          "vimdoc",

          -- https://neovim.discourse.group/t/treesitter-not-parsing-todo-comments-correctly/1066
          "comment",

          "make",

          "sql",

          "python",
          "requirements",

          "query",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        -- -- List of parsers to ignore installing (for "all")
        -- ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            enable = true,

            -- -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- -- the name of the parser)
            -- -- list of language that will be disabled
            -- disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }

-- nvim-colorize {{{1
    -- https://github.com/NvChad/nvim-colorizer.lua
    -- https://neovimcraft.com/plugin/NvChad/nvim-colorizer.lua
    -- Maintained fork of the fastest Neovim colorizer
    require 'colorizer'.setup()

-- nvim-autopairs {{{1
    -- https://github.com/windwp/nvim-autopairs
    -- autopairs for neovim written by lua
    require("nvim-autopairs").setup {}
