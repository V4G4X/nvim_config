-- Initialise MiniAnimate plugin

function InitMiniAnimate()
    local animate = require('mini.animate')
    animate.setup({
        cursor = {
            -- Animate with line-column angle instead of shortest line
            path = animate.gen_path.angle(),
            timing = animate.gen_timing.linear({ duration = 25, unit = 'total' }),
        },
        resize = {
            -- Animate for 200 milliseconds with linear easing
            timing = animate.gen_timing.linear({ duration = 10, unit = 'total' }),
        },
    })
end

function ToggleScrollAnimation()
    local animate = require('mini.animate')
    animate.config.scroll.enable = not animate.config.scroll.enable
end

if not vim.g.vscode then InitMiniAnimate() end
