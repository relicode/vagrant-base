#!/bin/sh

TMUX_DIR="${HOME}/etc/oh-my-tmux"

mkdir -p "${TMUX_DIR}"
git clone --depth 1 https://github.com/gpakosz/.tmux.git "${TMUX_DIR}"
ln -s "${TMUX_DIR}/.tmux.conf" "${HOME}"
