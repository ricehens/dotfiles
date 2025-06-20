return {
    "mfussenegger/nvim-jdtls",
    ft = "java",  -- 仅在 Java 文件中加载
    config = function()
        local jdtls = require("jdtls")
        local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        local path_to_lsp_server = jdtls_path .. "/config_mac_arm"  -- 根据您的系统调整 (win/mac/linux)
        local path_to_plugins = jdtls_path .. "/plugins/"
        local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_*.jar"
        local lombok_path = jdtls_path .. "/lombok.jar"  -- 如果需要 Lombok
        local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extnesion/server/com.microsoft.java.debug.plugin-*.jar"

        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
        local root_dir = vim.fs.root(0, root_markers)
        local project_name = (root_dir ~= nil and root_dir ~= vim.NIL) and vim.fn.fnamemodify(root_dir, ":p:h:t") or "tmp"
        local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

        local config = {
            cmd = {
                "java",
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-javaagent:" .. lombok_path,  -- 如果使用 Lombok
                "-Xms1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens", "java.base/java.util=ALL-UNNAMED",
                "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                "-jar", vim.fn.glob(path_to_jar),
                "-configuration", path_to_lsp_server,
                "-data", workspace_dir,
            },

            root_dir = root_dir,

            settings = {
                java = {
                    signatureHelp = { enabled = true },
                    contentProvider = { preferred = "fernflower" },
                    completion = {
                        favoriteStaticMembers = {
                            "org.junit.Assert.*",
                            "org.junit.jupiter.api.Assertions.*",
                        }
                    },
                    sources = {
                        organizeImports = {
                            starThreshold = 5,
                            staticStarThreshold = 5,
                        }
                    },
                    configuration = {
                        runtimes = {
                            -- 添加您的 JDK 路径
                            { name = "JavaSE-24", path = "/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home" },
                            { name = "JavaSE-17", path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home" },
                        }
                    },
                    format = { 
                        enabled = true,
                        settings = {
                            url = vim.fn.expand("$HOME/.config/nvim/lsp/java.xml"),
                            profile = "Default",
                        },
                    },
                }
            },

            init_options = {
                bundles = {
                    java_debug_path,
                }  -- 可添加额外的扩展包
            },
        }

        -- Java 特定键映射
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                -- 设置 LSP 客户端
                require("jdtls").start_or_attach(config)

                local opts = { buffer = true, silent = true }

                -- 代码操作
                vim.keymap.set("n", "<leader>co", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "组织导入" }))
                vim.keymap.set("n", "<leader>ct", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "测试类" }))
                vim.keymap.set("n", "<leader>cm", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "测试方法" }))
                vim.keymap.set("n", "<leader>ce", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "提取变量" }))
                vim.keymap.set("v", "<leader>ce", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "提取变量" }))
                vim.keymap.set("n", "<leader>cc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "提取常量" }))
                vim.keymap.set("v", "<leader>cc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "提取常量" }))

                -- 调试功能
                -- vim.keymap.set("n", "<leader>db", jdtls.dap.test_class, vim.tbl_extend("force", opts, { desc = "调试测试类" }))
                -- vim.keymap.set("n", "<leader>ds", jdtls.dap.test_nearest_method, vim.tbl_extend("force", opts, { desc = "调试测试方法" }))
            end
        })
    end
}
