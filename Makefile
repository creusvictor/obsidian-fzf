.PHONY: install uninstall install-user uninstall-user test help

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
USER_BINDIR ?= $(HOME)/.local/bin

help:
	@echo "obsidian-fzf - Makefile targets:"
	@echo ""
	@echo "  make install         Install to $(PREFIX)/bin (requires sudo)"
	@echo "  make uninstall       Remove from $(PREFIX)/bin (requires sudo)"
	@echo "  make install-user    Install to $(HOME)/.local/bin (no sudo needed)"
	@echo "  make uninstall-user  Remove from $(HOME)/.local/bin"
	@echo "  make test            Run syntax check on the script"
	@echo "  make help            Show this help message"
	@echo ""

install:
	@echo "Installing obsidian-fzf to $(BINDIR)..."
	install -d $(BINDIR)
	install -m 755 obsidian-fzf $(BINDIR)/obsidian-fzf
	@echo "✓ Installation complete!"
	@echo "Run 'obsidian-fzf' to start"

uninstall:
	@echo "Removing obsidian-fzf from $(BINDIR)..."
	rm -f $(BINDIR)/obsidian-fzf
	@echo "✓ Uninstallation complete!"

install-user:
	@echo "Installing obsidian-fzf to $(USER_BINDIR)..."
	install -d $(USER_BINDIR)
	install -m 755 obsidian-fzf $(USER_BINDIR)/obsidian-fzf
	@echo "✓ Installation complete!"
	@echo "Make sure $(USER_BINDIR) is in your PATH"
	@echo "Run 'obsidian-fzf' to start"

uninstall-user:
	@echo "Removing obsidian-fzf from $(USER_BINDIR)..."
	rm -f $(USER_BINDIR)/obsidian-fzf
	@echo "✓ Uninstallation complete!"

test:
	@echo "Running syntax check..."
	@bash -n obsidian-fzf && echo "✓ Syntax OK"
	@echo ""
	@echo "Checking for required dependencies..."
	@command -v fzf >/dev/null 2>&1 && echo "  ✓ fzf found" || echo "  ✗ fzf not found"
	@command -v rg >/dev/null 2>&1 && echo "  ✓ ripgrep (rg) found" || echo "  ✗ ripgrep (rg) not found"
	@command -v bat >/dev/null 2>&1 && echo "  ✓ bat found" || echo "  ✗ bat not found"
	@command -v python3 >/dev/null 2>&1 && echo "  ✓ python3 found" || echo "  ✗ python3 not found"
