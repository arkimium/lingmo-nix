{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "buildkite-agent-metrics";
  version = "5.9.7";

  outputs = [ "out" "lambda" ];

  src = fetchFromGitHub {
    owner = "buildkite";
    repo = "buildkite-agent-metrics";
    rev = "v${version}";
    hash = "sha256-HHTPgrMNxaX2fbkf7oasrEopXg6ocMSwdymeNAIrckg=";
  };

  vendorHash = "sha256-i2+nefRE4BD93rG842oZj0/coamYVRMPxEHio80bdWk=";

  postInstall = ''
    mkdir -p $lambda/bin
    mv $out/bin/lambda $lambda/bin
  '';

  meta = with lib; {
    description = "Command-line tool (and Lambda) for collecting Buildkite agent metrics";
    homepage = "https://github.com/buildkite/buildkite-agent-metrics";
    license = licenses.mit;
    maintainers = teams.determinatesystems.members;
  };
}
