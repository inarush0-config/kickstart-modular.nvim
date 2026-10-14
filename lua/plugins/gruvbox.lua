return {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 900,
    config = function()
        -- Tint the background of diagnostic ranges with the severity colour so the
        -- undercurl colour is easier to spot. Recomputed on every colorscheme load
        -- so it follows dark/light switches.
        vim.api.nvim_create_autocmd('ColorScheme', {
            group = vim.api.nvim_create_augroup('diagnostic-underline-tint', { clear = true }),
            callback = function()
                local function blend(fg, bg, alpha)
                    local function channel(shift)
                        local f = bit.band(bit.rshift(fg, shift), 0xff)
                        local b = bit.band(bit.rshift(bg, shift), 0xff)
                        return bit.lshift(math.floor(f * alpha + b * (1 - alpha) + 0.5), shift)
                    end
                    return channel(16) + channel(8) + channel(0)
                end

                local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal', link = false }).bg
                if not normal_bg then
                    return
                end

                for _, severity in ipairs { 'Error', 'Warn', 'Info', 'Hint' } do
                    local color = vim.api.nvim_get_hl(0, { name = 'Diagnostic' .. severity, link = false }).fg
                    if color then
                        vim.api.nvim_set_hl(0, 'DiagnosticUnderline' .. severity, {
                            undercurl = true,
                            sp = color,
                            bg = blend(color, normal_bg, 0.2),
                        })
                    end
                end
            end,
        })

        vim.o.background = 'dark'
        vim.cmd.colorscheme 'gruvbox'
    end,
}
