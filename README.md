# rcvd packaging  

Distro package recipes and service files for `rcvd`, the encryption-only DNS engine:
https://github.com/rcvd-dns/rcvd

Each recipe pins an `rcvd` release version and the hash of that release's source, so packaging
fixes never require a change to the engine repo.

## Layout  

| Directory | Target | Notes |
|-----------|--------|------------------|
| `pkgbuild/` | Arch Linux AUR (Arch, Omarchy, other Arch-based distros) | not yet published |
| `nix/` | nixpkgs (`pkgs/by-name/rc/rcvd`) | https://github.com/NixOS/nixpkgs |
| `pkgsrc/` | pkgsrc `net/rcvd` (NetBSD, SmartOS, illumos, other pkgsrc platforms) | https://gnats.netbsd.org/60775 |
| `services/` | systemd, OpenRC, launchd units for manual installs | n/a |

Packaging that lives in its own location:

- Alpine Linux: aports, https://pkgs.alpinelinux.org/packages?name=rcvd (`apk add rcvd`)

- Homebrew: https://github.com/rcvd-dns/homebrew-rcvd (macOS and Linux)

## Local Builds  

```sh
# Nix
nix-build nix

# Arch Linux, Omarchy, other Arch-based distros
cd pkgbuild && makepkg -s

# pkgsrc (NetBSD, SmartOS, illumos, other pkgsrc platforms):
# copy pkgsrc/ to /usr/pkgsrc/net/rcvd, then
cd /usr/pkgsrc/net/rcvd && make package && pkglint
```

## Precompiled Release Builds  

Binaries for each release are on the GitHub and GitLab release pages:

- https://github.com/rcvd-dns/rcvd/releases
- https://gitlab.com/rcvd-dns/rcvd/-/releases

## License  

MIT See `LICENSE`.
