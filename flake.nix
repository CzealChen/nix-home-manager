{
  description = "Czealchen's Nix Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    dotfiles = {
      url = "github:CzealChen/dotfiles";
      flake = false;
    };
  };

    outputs = { nixpkgs, home-manager, dotfiles, 
    ... } @ inputs: let 
      username = "czealchen";
      common-modules = [
      ./home/home.nix    
      ./home/common.nix  
    ];
      
    in{
      inherit common-modules;
      homeConfigurations = {
        "linux"= home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux"; 
          };
          extraSpecialArgs = {
          inherit inputs;
          inherit dotfiles;
          };
          modules = common-modules ++ [ {
            home={
              username = username;
              homeDirectory = "/home/${username}";
              stateVersion = "25.05";
            };
          }];
        };
        "darwin" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "aarch64-darwin"; 
            };
            extraSpecialArgs = {
            inherit inputs;
            inherit dotfiles;
            };
            modules = common-modules ++ [ {
            home={
              username = username;
              homeDirectory = "/Users/${username}";
              stateVersion = "25.05";
            };
          }];
          };
    };    

    };
}

