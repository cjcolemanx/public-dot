local status, dressing = pcall(require, "dressing")

if not status then
	return
end

dressing.setup({
	input = {
		insert_only = true,
	},
})
