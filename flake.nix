{
  description = "Package the hello repeater.";
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.zig =
      let pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      in
      pkgs.stdenv.mkDerivation {
        pname = "zig";
        version = "0.7.1";
        src = pkgs.fetchgit {
          url = "https://github.com/ziglang/zig.git";
          rev = "0.7.1";
          sha256 = "sha256-rZYv8LFH3M70SyPwPVyul+Um9j82K8GZIepVmaonzPw=";
        };
        nativeBuildInputs = with pkgs; [
          cmake
          llvmPackages_11.clang-unwrapped
          llvmPackages_11.llvm
          llvmPackages_11.lld
          libxml2
          zlib
        ];
      };
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.zig;
  };
}
