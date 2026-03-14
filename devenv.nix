{
  config,
  pkgs,
  ...
}:

let
  standaloneProjectRoot = toString ./.;
  agentBrowser = pkgs.rustPlatform.buildRustPackage {
    pname = config.rustEnv.package.name;
    version = config.rustEnv.package.version;
    src = config.outputs.cargo_source_tree;
    cargoLock.lockFile = ./Cargo.lock;
    doCheck = false;
  };
in
{
  rustEnv.managedCargo = {
    enable = true;
    specPath = "${standaloneProjectRoot}/Cargo.poly.toml";
  };

  outputs.agent-browser = agentBrowser;

  scripts = {
    workspace-check.exec = ''
      cargo check --workspace
    '';
  };

  enterShell = ''
    echo "Run: show-workspace-manifest"
    echo "Run: workspace-check"
  '';
}
