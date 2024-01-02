#! /usr/bin/env bash
mkdir -p ~/.config/systemd/user/default.target.wants
ln -s /run/current-system/sw/lib/systemd/user/pipewire.service ~/.config/systemd/user/default.target.wants/
ln -s /run/current-system/sw/lib/systemd/user/wireplumber.service ~/.config/systemd/user/default.target.wants/
systemctl --user daemon-reload
systemctl --user enable pipewire.service --now
systemctl --user enable wireplumber.service --now
systemctl --user enable pipewire-pulse --now 