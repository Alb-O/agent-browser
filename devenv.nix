{
  inputs,
  ...
}:
{
  rustEnv.managedCargo.enable = true;

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
