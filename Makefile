.PHONY: help stow

help:
	@scripts/stow-packages.sh --help

stow:
	@scripts/stow-packages.sh $(ARGS)
