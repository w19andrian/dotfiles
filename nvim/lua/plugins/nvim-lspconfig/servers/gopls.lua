return {
	tools = {
		"gofumpt",
	},
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			hints = {
				parameterNames = true,
				assignVariableTypes = true,
			},
		},
	},
}
