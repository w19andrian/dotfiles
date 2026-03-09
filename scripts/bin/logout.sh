#!/usr/bin/env bash

set -euo pipefail

# Close all flatpak apps
for instance in $(flatpak ps --columns=instance | awk 'NR > 0'); do
	flatpak kill $instance
done

# Try graceful Plasma 6 logout (no dialog, no error if unavailable)
qdbus-qt6 org.kde.Shutdown /Shutdown org.kde.Shutdown.logout >/dev/null 2>&1 || true
sleep 1

sudo systemctl restart sddm.service

# If i3 is still running, exit it gracefully
pgrep -x i3 >/dev/null && i3-msg -q exit || true

