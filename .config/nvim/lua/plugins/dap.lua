-- debugging
return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        { 'jay-babu/mason-nvim-dap.nvim' },
        { 'mfussenegger/nvim-dap' },
        { 'mxsdev/nvim-dap-vscode-js' },
        { 'williamboman/mason.nvim' },
        { 'theHamsta/nvim-dap-virtual-text' },
        { 'nvim-telescope/telescope-dap.nvim' },
        {
            'microsoft/vscode-js-debug',
            opt = true,
            build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
        },
    },
    config = function()
        local mason = require('mason')
        local mason_dap = require('mason-nvim-dap')
        local dap = require('dap')
        local dapui = require('dapui')

        dap.set_log_level('TRACE')

        dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
        end

        -- ╭──────────────────────────────────────────────────────────╮
        -- │ Debuggers                                                │
        -- ╰──────────────────────────────────────────────────────────╯
        -- We need the actual programs to connect to running instances of our code.
        -- Debuggers are installed via https://github.com/jayp0521/mason-nvim-dap.nvim
        -- The VSCode debugger requires a special adapter, seen in /lua/plugins/dap/adapters.lua
        mason.setup()
        mason_dap.setup({
            ensure_installed = {
                -- 'delve@v1.20.2',
                -- 'node2@v1.43.0',
                -- 'js@v1.77.0',
            },
            automatic_installation = true
        })

        -- ╭──────────────────────────────────────────────────────────╮
        -- │ Keybindings + UI                                         │
        -- ╰──────────────────────────────────────────────────────────╯
        vim.fn.sign_define('DapBreakpoint', { text = '🐞' })

        local function dap_start_debugging()
            dap.continue({})
            vim.cmd('tabedit %')
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o>', false, true, true), 'n', false)
            dapui.toggle({})
        end

        vim.keymap.set('n', '<localleader>ds', dap_start_debugging)
        vim.keymap.set('n', '<localleader>dl', require('dap.ui.widgets').hover)
        vim.keymap.set('n', '<localleader>dc', dap.continue)
        vim.keymap.set('n', '<localleader>db', dap.toggle_breakpoint)
        vim.keymap.set('n', '<localleader>dn', dap.step_over)
        vim.keymap.set('n', '<localleader>di', dap.step_into)
        vim.keymap.set('n', '<localleader>do', dap.step_out)

        local function dap_clear_breakpoints()
            dap.clear_breakpoints()
            require('notify')('Breakpoints cleared', 'warn')
        end

        vim.keymap.set('n', '<localleader>dC', dap_clear_breakpoints)

        -- TODO: How to get current adapter config? Could restart with current arguments
        local function dap_restart_current_session()
            dap.terminate()
            vim.defer_fn(
                function()
                    dap.continue()
                end,
                300)
        end

        vim.keymap.set('n', '<localleader>dr', dap_restart_current_session)

        local function dap_end_debug()
            dap.clear_breakpoints()
            dapui.toggle({})
            dap.terminate({}, { terminateDebuggee = true }, function()
                vim.cmd.bd()
                -- dapui.resize_vertical_splits()
                require('notify')('Debugger session ended', 'warn')
            end)
        end

        vim.keymap.set('n', '<localleader>de', dap_end_debug)

        -- UI Settings
        dapui.setup({
            icons = { expanded = '▾', collapsed = '▸' },
            mappings = {
                expand = { '<CR>', '<2-LeftMouse>' },
                open = 'o',
                remove = 'd',
                edit = 'e',
                repl = 'r',
                toggle = 't',
            },
            layouts = {
                {
                    elements = {
                        'scopes',
                    },
                    size = 0.3,
                    position = 'right'
                },
                {
                    elements = {
                        'repl',
                        'breakpoints'
                    },
                    size = 0.3,
                    position = 'bottom',
                },
            },
            floating = {
                -- max_height = nil,
                -- max_width = nil,
                border = 'rounded',
                mappings = {
                    close = { 'q', '<Esc>' },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil,
            },
        })
    end
}
