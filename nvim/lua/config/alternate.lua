local M = {}

-- Define file alternates here.
-- Each entry uses a Lua pattern `pattern` matched against the absolute file path.
-- Captures from the pattern are substituted into every target with %1, %2, etc.
-- Targets can use globs (e.g. *.tsx) and are resolved from the project root.
M.mappings = {
  {
    pattern = "/app/controllers/(.*)_controller%.rb",
    targets = {
      "/app/javascript/pages/%1/*.tsx",
      "/app/views/%1/*",
      "/app/views/%1/**/*",
      "/test/controllers/%1_controller_test.rb",
      "/test/integration/%1_controller_test.rb",
    },
  },
  {
    pattern = "/test/controllers/(.*)_controller_test%.rb",
    targets = {
      "/app/controllers/%1_controller.rb",
      "/app/views/%1/*",
      "/app/views/%1/**/*",
    },
  },
  {
    pattern = "/test/integration/(.*)_controller_test%.rb",
    targets = {
      "/app/controllers/%1_controller.rb",
      "/app/views/%1/*",
      "/app/views/%1/**/*",
    },
  },
  {
    pattern = "/app/javascript/pages/(.*)/.*%.tsx",
    targets = {
      "/app/controllers/%1_controller.rb",
      "/app/javascript/pages/%1/*.test.tsx",
      "/app/javascript/pages/%1/__tests__/*.test.tsx",
    },
  },
  {
    pattern = "/app/models/(.*)%.rb",
    targets = {
      "/test/models/%1_test.rb",
      "/test/unit/%1_test.rb",
    },
  },
  {
    pattern = "/test/models/(.*)_test%.rb",
    targets = {
      "/app/models/%1.rb",
    },
  },
  {
    pattern = "/test/unit/(.*)_test%.rb",
    targets = {
      "/app/models/%1.rb",
    },
  },
}

return M
