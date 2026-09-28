# dotfiles

This repository contains my personal dotfiles, managed by [chezmoi](https://chezmoi.io/).

## Managed Configurations

- **omp**: Core agent configurations (`~/.omp/agent/config.yml`, `AGENTS.md`)
- **herdr**: `~/.config/herdr/`
- **kitty**: `~/.config/kitty/`
- **fish**: `~/.config/fish/`
- **ghostty**: `~/.config/ghostty/`
- **Windows Terminal**: `~/.config/windows-terminal.json` (Reference Paper scheme and PowerShell profile defaults)
- **nvim**: `~/.config/nvim/`
- **pi**: `~/.pi/agent/settings.json`, reference-paper theme and customization
- **tmux**: `~/.tmux.conf`

Pi credentials (`auth.json`), model caches, installed binaries, package checkouts, backups, and portable archives are intentionally not managed. The Pi customization path in `settings.json` is templated for the target home directory.

## Usage

To apply these dotfiles on a new machine:

```bash
chezmoi init --apply https://github.com/kuroega/chezmoi.git
```
