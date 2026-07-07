if command -v tmux >/dev/null && [[ -z "$TMUX" ]]; then
  exec tmux new-session -A -s main
fi
