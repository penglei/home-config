mkdir -p ~/.ssh
mkdir -p ~/.config/nix/
curl https://github.com/penglei.keys >>~/.ssh/authorized_keys

cat <<EOF >~/.config/nix/nix.conf
experimental-features = nix-command flakes ca-derivations
keep-outputs = true
keep-derivations = true
max-jobs = auto
EOF
