{
  description = "A flake defining Python with some extras";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
  };

  outputs = { self, nixpkgs }: let

    pypkgs = ps: with ps; [
      jupyterlab
      matplotlib
      numpy
      pandas
      plotnine
      pytorch
      requests
      scikit-learn
      scipy
      xgboost
    ];

    package = { system }:
      let pkgs = import nixpkgs { system = system; };
      in pkgs.python310.withPackages pypkgs;

  in {
    packages.x86_64-linux.default = package {
      system = "x86_64-linux";
    };
    packages.x86_64-darwin.default = package {
      system = "x86_64-darwin";
    };
    packages.aarch64-darwin.default = package {
      system = "aarch64-darwin";
    };
  };
}
