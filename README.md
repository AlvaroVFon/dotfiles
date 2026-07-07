# dotfiles

Personal dotfiles and setup scripts for Fedora Linux.

## Usage

```bash
# Full install (all modules)
./install.sh

# Install specific modules
./install.sh zsh nvim tmux

# Update everything
./install.sh --update
```

## Modules

| Module | Description |
|---|---|
| `rpmfusion` | RPM Fusion repositories + ffmpeg |
| `essentials` | ripgrep, fd, fzf, bat, eza, zoxide, jq, btop |
| `fonts` | FiraCode Nerd Font |
| `zsh` | Zsh, Oh My Zsh, plugins, Starship |
| `nvim` | Neovim (LazyVim) |
| `tmux` | Tmux + TPM + plugins |
| `ghostty` | Ghostty terminal |
| `lazygit` | Lazygit |
| `yazi` | Yazi file manager |
| `vscode` | VS Code + extensions |
| `node` | fnm + Node.js LTS + pnpm |
| `python` | Pyenv + pipx + uv |
| `rust` | Rustup + stable toolchain |
| `go` | Go |
| `docker` | Docker CE (or Podman with `USE_PODMAN=true`) |
