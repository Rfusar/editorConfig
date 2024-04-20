local training = require("nvim-training")
training.setup({
	task_list = {
		"MoveEndOfLine",
		"MoveStartOfLine",
		"MoveEndOfFile",
		"MoveStartOfFile",
		"SearchForward",
		"Increment",
		"YankEndOfLine",
		"YankIntoRegister",
	},
	task_scheduler = "RandomScheduler",
})
