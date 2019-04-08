let
  nodejs-11_13_0 = self: super: {
    nodejs-11_13_0 = self.callPackage (import ./packages/nodejs-11_13_0) {};
  };
in
[ nodejs-11_13_0 ]
