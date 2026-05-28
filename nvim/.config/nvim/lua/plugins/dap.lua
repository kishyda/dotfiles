return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            require("dapui").setup()
        end
    },
    { 
        "rcarriga/nvim-dap-ui", 
        dependencies = {
            "mfussenegger/nvim-dap", 
            "nvim-neotest/nvim-nio"
        },
        config = function()
            require("dapui").setup()
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        config = function()
            require("dap-python").setup("uv")
        end
    },
}
