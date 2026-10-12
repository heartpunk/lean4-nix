{
  tag = "v4.34.1";
  rev = "5045d0056413266e57c625dcd7c365b10e377c52";
  toolchain = {
    aarch64-linux = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.34.1/lean-4.34.1-linux_aarch64.tar.zst";
      hash = "sha256-/bl0ws20Yn4JDV1AB7kT4J0TxIaHIPtVlOIoCLPenjc=";
    };
    x86_64-linux = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.34.1/lean-4.34.1-linux.tar.zst";
      hash = "sha256-R79LvXj3DC6WcFmKtxJNkrbvtzMP8z5fu0Aw9v1y5OQ=";
    };
    x86_64-darwin = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.34.1/lean-4.34.1-darwin.tar.zst";
      hash = "sha256-wv7nAlBETkbBEGonvd/vlI0eVj7vQx6qwFu5RrL3PTo=";
    };
    aarch64-darwin = {
      url = "https://github.com/leanprover/lean4/releases/download/v4.34.1/lean-4.34.1-darwin_aarch64.tar.zst";
      hash = "sha256-ZfIqTwR3OOx0JmezJH6Daobr8G6rwSZVw97gBjfjeGY=";
    };
  };
  inherit (import ./v4.31.0.nix) bootstrap buildLeanPackage;
}
