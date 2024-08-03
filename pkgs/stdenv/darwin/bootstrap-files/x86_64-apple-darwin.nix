# Autogenerated by maintainers/scripts/bootstrap-files/refresh-tarballs.bash as:
# $ ./refresh-tarballs.bash --targets=x86_64-apple-darwin
#
# Metadata:
# - nixpkgs revision: d03a4482228d4d6dbd2d4b425b6dfcd49ebe765f
# - hydra build: https://hydra.nixos.org/job/nixpkgs/trunk/stdenvBootstrapTools.x86_64-apple-darwin.build/latest
# - resolved hydra build: https://hydra.nixos.org/build/255281731
# - instantiated derivation: /nix/store/44wnr0ikrbcxkakfqhhm2cz6gsh6wjni-stdenv-bootstrap-tools.drv
# - output directory: /nix/store/lsl9rl3zj9nr318w471vvmlvxzj21b2k-stdenv-bootstrap-tools
# - build time: Wed, 03 Apr 2024 07:56:15 +0000
{
  bootstrapTools = import <nix/fetchurl.nix> {
    url = "http://tarballs.nixos.org/stdenv/x86_64-apple-darwin/d03a4482228d4d6dbd2d4b425b6dfcd49ebe765f/bootstrap-tools.tar.xz";
    hash = "sha256-3OBigzlbu/Z6g8r7hsOWg95HTv7IJw9Nvbamwvw+88w=";
  };
  unpack = import <nix/fetchurl.nix> {
    url = "http://tarballs.nixos.org/stdenv/x86_64-apple-darwin/d03a4482228d4d6dbd2d4b425b6dfcd49ebe765f/unpack.nar.xz";
    hash = "sha256-93GK8LjjgUBknxsylfGVr0DG4AbWVIQEIWrwxhDW07k=";
    name = "unpack";
    unpack = true;
  };
}