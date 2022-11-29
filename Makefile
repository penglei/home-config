pin-registry:
	@nix registry pin nixpkgs "github:NixOS/nixpkgs/$$(cat flake.lock|jq -r .nodes.nixpkgs.locked.rev)"
	@nix registry pin home-manager github:nix-community/home-manager/$$(cat flake.lock|jq -r '.nodes["home-manager"].locked.rev')
