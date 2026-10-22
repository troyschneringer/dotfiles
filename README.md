
Clone the repo

Create a symbolic link to the corresponding file

```
ln -s dotfiles/.gitconfig ~/.gitconfig
ln -s dotfiles/.inputrc ~/.inputrc
ln -s dotfiles/.zshrc ~/.zshrc
ln -s dotfiles/agents.md ~/.claude/CLAUDE.md
ln -s dotfiles/settings.json ~/.claude/settings.json
```

## Claude Code

[claude/agents.md](claude/agents.md) contains global local-development safety
instructions. [claude/settings.json](claude/settings.json) preserves the existing
`"theme": "auto"` setting and adds permission guardrails.

Claude loads global instructions from `~/.claude/CLAUDE.md`, so link that name to
`agents.md`, not to `~/.claude/agents.md`.