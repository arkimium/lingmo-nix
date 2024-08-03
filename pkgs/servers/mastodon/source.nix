# This file was generated by pkgs.mastodon.updateScript.
{ fetchFromGitHub, applyPatches, patches ? [] }:
let
  version = "4.2.10";
in
(
  applyPatches {
    src = fetchFromGitHub {
      owner = "mastodon";
      repo = "mastodon";
      rev = "v${version}";
      hash = "sha256-z3veI0CpZk6mBgygqXk8SN/5WWjy5VkKLxC7nOLnyZE=";
    };
    patches = patches ++ [];
  }) // {
  inherit version;
  yarnHash = "sha256-qoLesubmSvRsXhKwMEWHHXcpcqRszqcdZgHQqnTpNPE=";
}
