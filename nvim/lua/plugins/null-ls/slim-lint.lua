local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local DIAGNOSTICS = methods.internal.DIAGNOSTICS

local handle_slim_lint_output = function(params)
    local file = params.output.files[1]
    if params.output and params.output.files then
        local parser = h.diagnostics.from_json({})
        local offenses = {}

        for _, offense in ipairs(file.offenses) do
            table.insert(offenses, {
                message = offense.message,
                line = offense.location.line,
                ruleId = offense.linter_name,
                level = offense.severity,
            })
        end

        return parser({ output = offenses })
    end

    return {}
end

return h.make_builtin({
    name = "slim-lint",
    meta = {
        url = "https://github.com/sds/slim-lint",
        description = "Tool for writing clean and consistent SLIM.",
    },
    method = DIAGNOSTICS,
    filetypes = { "slim" },
    generator_opts = {
        command = "slim-lint",
        args = { "--reporter", "json", "$FILENAME" },
        to_stdin = true,
        from_stderr = true,
        to_temp_file = true,
        format = "json",
        check_exit_code = function(code)
            return code <= 1
        end,
        on_output = handle_slim_lint_output,
    },
    factory = h.generator_factory,
})
