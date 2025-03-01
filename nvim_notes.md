#

See a excellent [video](https://www.youtube.com/watch?v=n4Lp4cV8YR0) on writing a new plugin


## Notes on lua
`require("neo-tree")` will execute the code in side `neo-tree.lua` and put the results into the meta table. Sometimes we have 
` local M = {}
M.example = function() {
}
return M`
In this case meta table will have the function that we can call

* after making a change to a script and to reload it, run
`:lua package.loaded["config.your_script"] = nil`
`require("config.your_script")


## inspect values:
print(vim.inspect(workspaces))
