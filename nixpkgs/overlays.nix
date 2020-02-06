let
  nodejs-11_13_0 = self: super: {
    nodejs-11_13_0 = self.callPackage (import ./packages/nodejs-11_13_0) {};
  };
  aws-sam-cli = self: super: {
    aws-sam-cli = self.callPackage (import ./packages/aws-sam-cli) {};
  };
  ormolu = self: super:
    let
      source = super.fetchFromGitHub {
        owner = "tweag";
        repo = "ormolu";
        rev = "de279d80122b287374d4ed87c7b630db1f157642"; # update as necessary
        sha256 = "0qrxfk62ww6b60ha9sqcgl4nb2n5fhf66a65wszjngwkybwlzmrv"; # as well
      };
    in
      {
        haskellPackages = super.haskellPackages.extend (hself: hsuper: {
          ormolu = self.callPackage source {};
        });
      };
in
[ nodejs-11_13_0 aws-sam-cli ormolu ]
