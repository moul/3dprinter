# can't run with --pure because we requires system's ssl certs
let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/470e4a9bbc98b171a7e733dfc9e62531f7b9ceca.tar.gz") {};
  venvDir = "./.venv-nix";
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
  ];

  shellHook = ''
    if [ -d "${venvDir}" ]; then
      echo "Virtualenv '${venvDir}' already exists"
    else
      echo "Creating virtualenv '${venvDir}'"
      ${pkgs.python3Packages.python.interpreter} -m venv "${venvDir}"
    fi
    source "${venvDir}/bin/activate"
    pip install -U pip
  '';
}
