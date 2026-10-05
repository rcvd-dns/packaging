# nixpkgs package for rcvd, in pkgs/by-name layout (pkgs/by-name/rc/rcvd/package.nix).
# Build locally from this directory: nix-build
{
  lib,
  buildGo127Module,
  fetchFromGitHub,
  installShellFiles,
  versionCheckHook,
}:

# go.mod requires Go 1.27; the nixpkgs default buildGoModule is still on 1.26.
buildGo127Module (finalAttrs: {
  pname = "rcvd";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "rcvd-dns";
    repo = "rcvd";
    tag = "v${finalAttrs.version}";
    hash = "sha256-2m8XH2SmB473QZokAOeRM0asWD+IAXM6jjFvuuncu28=";
  };

  vendorHash = "sha256-P0EI2eaW/BB0jUbSfnELBdvMYTjoPaEcA2g39Fh3p6M=";

  subPackages = [ "cmd/rcvd" ];

  env.CGO_ENABLED = 0;

  # Same stamping as the Makefile and other distro packages. buildDate is pinned
  # to the epoch for reproducibility.
  ldflags = [
    "-s"
    "-w"
    "-X main.version=${finalAttrs.version}"
    "-X main.buildDate=1970-01-01T00:00:00Z"
    "-X main.buildSource=nixpkgs"
  ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installManPage man/rcvd.1
    install -Dm644 etc/*.toml -t $out/share/doc/rcvd/examples
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;
  versionCheckProgramArg = "--version";

  meta = {
    description = "Privacy-first encrypted DNS engine (DoQ/DoT/DoH)";
    homepage = "https://rcvd.net";
    changelog = "https://github.com/rcvd-dns/rcvd/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    mainProgram = "rcvd";
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    maintainers = [ ];
  };
})
