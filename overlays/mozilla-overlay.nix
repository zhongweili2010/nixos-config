self: super:

let
  mozillaOverlay = import (fetchTarball "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz");
in
  mozillaOverlay self super
