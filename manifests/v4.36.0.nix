{
  tag = "v4.36.0";
  rev = "611c117bfaf7b7ae1cfcf246ce6fba31e8f509e9";
  toolchain = {
    aarch64-linux = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.36.0/lean-4.36.0-linux_aarch64.tar.zst";
      hash = "sha256-NUcZmBUhke+AlBjOW/Yfj8XyCeXjvgW0i9xJSf2z5yY=";
    };
    x86_64-linux = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.36.0/lean-4.36.0-linux.tar.zst";
      hash = "sha256-K3qx7YuS0uar+vQTRII7UQBk28nAJgysc+tJarLepus=";
    };
    x86_64-darwin = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.36.0/lean-4.36.0-darwin.tar.zst";
      hash = "sha256-R2+dz3vuagcOOaaxXKt62kiwCGvZHW5hqhpFTT2kCc4=";
    };
    aarch64-darwin = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.36.0/lean-4.36.0-darwin_aarch64.tar.zst";
      hash = "sha256-SaytqHSa0TQ+/xIko9JRCsYe1TNj03tec46MWH596r0=";
    };
  };
  inherit (import ./v4.35.0.nix) bootstrap buildLeanPackage;
}
