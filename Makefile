.PHONY: fmt
fmt:
	stylua --config-path .stylua.toml init.lua

.PHONY: lint
lint:
	luacheck .

update:
	python update_neovim.py