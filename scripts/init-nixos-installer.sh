#tips:

#curl -L http://gg.gg/nixos-install -o - | sudo sh

mkdir -p ~/.ssh
mkdir -p ~/.config/nix/
curl https://github.com/penglei.keys >>~/.ssh/authorized_keys

cat <<EOF >~/.config/nix/nix.conf
experimental-features = nix-command flakes ca-derivations
keep-outputs = true
keep-derivations = true
max-jobs = auto
EOF

if [ -n "$VM_PROFILE"]; then
	nix run github:penglei/nix-configs#nixpkgs.nixos-installer.make-vm-disk
	nixos-install --flake github:penglei/nix-configs#$VM_PROFILE --no-root-password
fi
