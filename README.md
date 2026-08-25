# dotfiles

This repository contains my personal dotfiles, managed by [chezmoi](https://chezmoi.io/).

## Managed Configurations

- **omp**: Core agent configurations (`~/.omp/agent/config.yml`, `AGENTS.md`)
- **herdr**: `~/.config/herdr/`
- **kitty**: `~/.config/kitty/`
- **fish**: `~/.config/fish/`
- **ghostty**: `~/.config/ghostty/`
- **nvim**: `~/.config/nvim/`
- **tmux**: `~/.tmux.conf`

## Usage

To apply these dotfiles on a new machine:

```bash
chezmoi init --apply https://github.com/kuroega/chezmoi.git
```
