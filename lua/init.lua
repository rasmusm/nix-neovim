local reload = require("c.reload")
reload.unload_user_modules()

local log = require("c.log")
log.init()

local layer = require("c.layer")
local keybind = require("c.keybind")
local autocmd = require("c.autocmd")

keybind.register_plugins()
autocmd.init()

layer.add_layer("l.colors")
layer.add_layer("l.fileman")
layer.add_layer("l.repl")
layer.add_layer("l.airline")
layer.add_layer("l.git")
layer.add_layer("l.lsp")
layer.add_layer("l.filetypes")
layer.finish_layer_registration()

keybind.post_init()
